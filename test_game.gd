extends Node2D

const SIDE_STEP = 5
const DROP_SPEED = 50
const FAST_DROP_SPEED = 3 * DROP_SPEED

var pieces: Array[PackedScene]
var last_piece: RigidBody2D

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
	_spawn_next_piece()

func _process(delta):
	var collision
	if Input.is_action_pressed("fast_drop"):
		collision = last_piece.move_and_collide(Vector2(0, FAST_DROP_SPEED * delta))
	else:
		collision = last_piece.move_and_collide(Vector2(0, DROP_SPEED * delta))
	if Input.is_action_just_pressed("move_right"):
		collision = last_piece.move_and_collide(Vector2(SIDE_STEP, 0))
	if Input.is_action_just_pressed("move_left"):
		collision = last_piece.move_and_collide(Vector2(-SIDE_STEP, 0))
	if Input.is_action_just_pressed("rotate_clockwise"):
		last_piece.rotate(PI / 2)
	if Input.is_action_just_pressed("rotate_anticlockwise"):
		last_piece.rotate(-PI / 2)
	if collision != null:
		_spawn_next_piece()

func _spawn_next_piece():
	if last_piece != null:
		last_piece.freeze = false
		last_piece.linear_velocity = Vector2.ZERO
	last_piece = pieces.pick_random().instantiate()
	last_piece.move_local_y(-250)
	last_piece.freeze = true
	last_piece.freeze_mode = RigidBody2D.FREEZE_MODE_KINEMATIC
	get_node(".").add_child(last_piece)
