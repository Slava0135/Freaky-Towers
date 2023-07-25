extends Node2D

const SIDE_STEP = 5
const DROP_SPEED = 50

var piece_scene
var last_piece: RigidBody2D

func _ready():
	piece_scene = preload("res://objects/shapes/square.tscn")
	_spawn_next_piece()

func _process(delta):
	if Input.is_action_pressed("ui_down"):
		last_piece.position -= Vector2(0, 2 * -DROP_SPEED * delta)
	else:
		last_piece.position -= Vector2(0, -DROP_SPEED * delta)
	if Input.is_action_just_pressed("ui_right"):
		last_piece.position += Vector2(SIDE_STEP, 0)
	if Input.is_action_just_pressed("ui_left"):
		last_piece.position -= Vector2(SIDE_STEP, 0)

func _spawn_next_piece():
	if last_piece != null:
		last_piece.body_entered.disconnect(_on_last_piece_collide)
		last_piece.freeze = false
	last_piece = piece_scene.instantiate()
	last_piece.contact_monitor = true
	last_piece.max_contacts_reported = 1
	last_piece.body_entered.connect(_on_last_piece_collide)
	last_piece.move_local_y(-250)
	last_piece.freeze = true
	last_piece.freeze_mode = RigidBody2D.FREEZE_MODE_KINEMATIC
	get_node(".").add_child(last_piece)

func _on_last_piece_collide(body):
	_spawn_next_piece()
