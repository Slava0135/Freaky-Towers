extends Node2D

const SIDE_STEP = 5
const DROP_SPEED = 50
const FAST_DROP_SPEED = 2 * DROP_SPEED

var piece_scene
var last_piece: RigidBody2D

func _ready():
	piece_scene = preload("res://objects/shapes/square.tscn")
	_spawn_next_piece()

func _process(delta):
	var collision
	if Input.is_action_pressed("ui_down"):
		collision = last_piece.move_and_collide(Vector2(0, FAST_DROP_SPEED * delta))
	else:
		collision = last_piece.move_and_collide(Vector2(0, DROP_SPEED * delta))
	if Input.is_action_just_pressed("ui_right"):
		collision = last_piece.move_and_collide(Vector2(SIDE_STEP, 0))
	if Input.is_action_just_pressed("ui_left"):
		collision = last_piece.move_and_collide(Vector2(-SIDE_STEP, 0))
	if collision != null:
		_spawn_next_piece()

func _spawn_next_piece():
	if last_piece != null:
		last_piece.freeze = false
		last_piece.linear_velocity = Vector2.ZERO
	last_piece = piece_scene.instantiate()
	last_piece.move_local_y(-250)
	last_piece.freeze = true
	last_piece.freeze_mode = RigidBody2D.FREEZE_MODE_KINEMATIC
	get_node(".").add_child(last_piece)
