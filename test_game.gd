extends Node2D

const SIDE_STEP = 5
const DROP_SPEED = 50
const FAST_DROP_SPEED = 3 * DROP_SPEED
const ROTATION_SPEED = 8

const SPAWN_OFFSET = 200

const CAMERA_LOW_OFFSET = 50
const CAMERA_HIGH_OFFSET = 50
const CAMERA_MIN_ZOOM = 1
const CAMERA_MAX_ZOOM = 3

var pieces: Array[PackedScene]

func _ready():
	pieces = [
		preload("res://objects/pieces/O.tscn"),
		preload("res://objects/pieces/I.tscn"),
		preload("res://objects/pieces/L.tscn"),
		preload("res://objects/pieces/J.tscn"),
		preload("res://objects/pieces/T.tscn"),
		preload("res://objects/pieces/S.tscn"),
		preload("res://objects/pieces/Z.tscn"),
	]
	spawn_next_piece()

var last_piece: RigidBody2D
var last_highest_y: float

var prev_rotation: float
var next_rotation: float
var elapsed: float
var rotate: bool

func _process(delta):
	if last_piece == null:
		spawn_next_piece()
	update_movement(delta)
	update_rotation(delta)
	update_camera(delta)

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
	var collision
	if Input.is_action_pressed("fast_drop"):
		collision = last_piece.move_and_collide(Vector2(0, FAST_DROP_SPEED * delta))
	else:
		collision = last_piece.move_and_collide(Vector2(0, DROP_SPEED * delta))
	if Input.is_action_just_pressed("move_right"):
		collision = last_piece.move_and_collide(Vector2(SIDE_STEP, 0))
	if Input.is_action_just_pressed("move_left"):
		collision = last_piece.move_and_collide(Vector2(-SIDE_STEP, 0))

	if collision != null:
		spawn_next_piece()

	if Input.is_action_just_pressed("nudge_right"):
		last_piece.move_and_collide(Vector2(SIDE_STEP, 0))
	if Input.is_action_just_pressed("nudge_left"):
		last_piece.move_and_collide(Vector2(-SIDE_STEP, 0))

func update_camera(delta):
	var cam: Camera2D = get_node("Camera")
	var highest = last_highest_y - CAMERA_HIGH_OFFSET
	var lowest = CAMERA_LOW_OFFSET
	var mid = (highest + lowest) / 2
	cam.position = lerp(cam.position, Vector2(0, mid), delta)
	var height = abs(highest - lowest)
	var view_h = abs(get_viewport_rect().size.y)
	var zoom = clampf(view_h / height, CAMERA_MIN_ZOOM, CAMERA_MAX_ZOOM)
	cam.zoom = lerp(cam.zoom, zoom * Vector2.ONE, delta)

func spawn_next_piece():
	if last_piece != null:
		last_piece.freeze = false
		last_piece.linear_velocity = Vector2.ZERO
	last_piece = pieces.pick_random().instantiate()
	last_piece.freeze = true
	last_piece.freeze_mode = RigidBody2D.FREEZE_MODE_KINEMATIC
	reset_rotation()
	last_highest_y = find_highest_y() - SPAWN_OFFSET
	last_piece.move_local_y(last_highest_y)
	get_node("ExistingPieces").add_child(last_piece)

func find_highest_y() -> float:
	var highest = 0
	for child in get_node("ExistingPieces").get_children():
		highest = min(child.position.y, highest)
	return highest

func reset_rotation():
	prev_rotation = 0
	next_rotation = 0
	elapsed = 0
	rotate = false
