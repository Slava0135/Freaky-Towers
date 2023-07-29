extends Control

func _ready():
	pass

func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://games/survival.tscn")
