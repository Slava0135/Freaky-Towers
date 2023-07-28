extends Node2D

const SIDE_STEP = 5
const DROP_SPEED = 50
const FAST_DROP_SPEED = 3 * DROP_SPEED
const ROTATION_SPEED = 8

const INPUT_DELAY = 0.1
const NUDGE_DELAY = 0.1

const NUDGE_IMPULSE = 100

const SPAWN_OFFSET = 200

const CAMERA_LOW_OFFSET = 100
const CAMERA_HIGH_OFFSET = 1.5 * SPAWN_OFFSET
const CAMERA_MIN_ZOOM = 1
const CAMERA_MAX_ZOOM = 3

var piece_loader = PieceLoad.new()

func _ready():
	pick_next_piece()
	spawn_next_piece()

var last_piece: RigidBody2D
var last_piece_data: PieceLoad.PieceData
var next_piece_data: PieceLoad.PieceData

var prev_rotation: float
var next_rotation: float
var elapsed: float
var rotate: bool

var next_input_delay: float
var nudge_delay: float
var nudge_direction: Vector2
var nudge_collided: bool

func _process(delta):
	if last_piece == null:
		spawn_next_piece()
	update_movement(delta)
	update_rotation(delta)
	update_camera(delta)
	update_beam()
	update_ui()

func update_ui():
	$UI/PieceCount.text = str($Level/ExistingPieces.get_child_count() - 1)

func update_rotation(delta):
	if not rotate:
		if Input.is_action_just_pressed("rotate_clockwise"):
			prev_rotation = last_piece.rotation
			next_rotation = last_piece.rotation + PI / 2
			rotate = true
		if Input.is_action_just_pressed("rotate_anticlockwise"):
			prev_rotation = last_piece.rotation
			next_rotation = last_piece.rotation - PI / 2
			rotate = true
	else:
		elapsed += ROTATION_SPEED * delta
		last_piece.rotation = lerp_angle(prev_rotation, next_rotation, elapsed)
		if elapsed > 1:
			last_piece.rotation = next_rotation
			elapsed = 0
			rotate = false

func update_movement(delta):
	next_input_delay -= delta
	nudge_delay -= delta

	if Input.is_action_just_pressed("nudge_right"):
		nudge_direction = Vector2.RIGHT
		nudge_delay = NUDGE_DELAY
	if Input.is_action_just_pressed("nudge_left"):
		nudge_direction = Vector2.LEFT
		nudge_delay = NUDGE_DELAY
	if nudge_delay > 0:
		nudge_collided = nudge_collided or last_piece.move_and_collide(nudge_direction * SIDE_STEP)

	var collision
	if Input.is_action_pressed("fast_drop"):
		collision = last_piece.move_and_collide(Vector2(0, FAST_DROP_SPEED * delta))
	else:
		collision = last_piece.move_and_collide(Vector2(0, DROP_SPEED * delta))

	if next_input_delay <= 0 and nudge_delay <= 0 and Input.is_action_pressed("move_right"):
		collision = last_piece.move_and_collide(Vector2(SIDE_STEP, 0))
		next_input_delay = INPUT_DELAY
	if next_input_delay <= 0 and nudge_delay <= 0 and Input.is_action_pressed("move_left"):
		collision = last_piece.move_and_collide(Vector2(-SIDE_STEP, 0))
		next_input_delay = INPUT_DELAY

	if nudge_delay <= 0 and (collision != null or nudge_collided):
		spawn_next_piece()
		nudge_collided = false

func update_camera(delta):
	var cam = $Level/Camera as Camera2D
	var highest = find_highest_y() - CAMERA_HIGH_OFFSET
	var lowest = CAMERA_LOW_OFFSET
	var mid = (highest + lowest) / 2
	var height = abs(highest - lowest)
	var view_h = abs(get_viewport_rect().size.y)
	var pos = Vector2(0, mid)
	var zoom = clampf(view_h / height, CAMERA_MIN_ZOOM, CAMERA_MAX_ZOOM)

	if is_equal_approx(zoom, CAMERA_MIN_ZOOM):
		pos = Vector2(0, highest + view_h / zoom / 2)

	cam.position = lerp(cam.position, pos, delta)
	cam.zoom = lerp(cam.zoom, zoom * Vector2.ONE, delta)

func update_beam():
	var beam = get_node("Level/BeamBorder") as Node2D
	beam.position = last_piece.position
	var width = last_piece_data.width(last_piece.rotation)
	beam.scale = Vector2(width, 1000000)

func spawn_next_piece():
	if last_piece != null:
		last_piece.freeze = false
		last_piece.linear_velocity = Vector2.ZERO
		last_piece.get_child(0).disabled = true
		last_piece.get_child(1).disabled = false
		if nudge_collided:
			last_piece.apply_impulse(nudge_direction * NUDGE_IMPULSE)
		$Level/DropAudio.play()
	last_piece_data = next_piece_data
	last_piece = last_piece_data.scene.instantiate()
	last_piece.freeze = true
	last_piece.freeze_mode = RigidBody2D.FREEZE_MODE_KINEMATIC
	reset_rotation()
	last_piece.move_local_y(find_highest_y() - SPAWN_OFFSET)
	last_piece.get_child(0).disabled = false
	last_piece.get_child(1).disabled = true
	$Level/ExistingPieces.add_child(last_piece)
	pick_next_piece()

func pick_next_piece():
	next_piece_data = piece_loader.random_piece()
	var next_piece_box = get_node("UI/NextPieceContainer/VBox/Texture") as TextureRect
	var next_piece = next_piece_data.scene.instantiate()
	var piece_sprite = next_piece.get_child(2) as Sprite2D
	next_piece_box.texture = piece_sprite.texture
	next_piece.queue_free()

func find_highest_y() -> float:
	var highest = 0
	for child in get_node("Level/ExistingPieces").get_children():
		if child != last_piece:
			highest = min(child.position.y, highest)
	return highest

func reset_rotation():
	prev_rotation = 0
	next_rotation = 0
	elapsed = 0
	rotate = false
