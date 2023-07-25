extends Node2D

const STEP = 10

var piece_scene
var last_piece: RigidBody2D

func _ready():
	piece_scene = preload("res://objects/shapes/square.tscn")
	_spawn_next_piece()

func _process(delta):
	if Input.is_action_pressed("move_right"):
		last_piece.position += Vector2(STEP, 0)
	if Input.is_action_pressed("move_left"):
		last_piece.position -= Vector2(-STEP, 0)

func _spawn_next_piece():
	if last_piece != null:
		last_piece.body_entered.disconnect(_on_last_piece_collide)
	last_piece = piece_scene.instantiate()
	last_piece.contact_monitor = true
	last_piece.max_contacts_reported = 1
	last_piece.body_entered.connect(_on_last_piece_collide)
	last_piece.move_local_y(-250)
	get_node(".").add_child(last_piece)

func _on_last_piece_collide(body):
	_spawn_next_piece()
