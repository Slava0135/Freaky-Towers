extends Node2D

func _ready():
	pass

func _process(delta):
	var square = preload("res://objects/shapes/square.tscn")
	var root = get_node(".")
	var squareInstance = square.instantiate()
	squareInstance.move_local_y(-250)
	root.add_child(squareInstance)
	pass
