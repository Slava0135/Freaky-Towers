extends Button

signal pause_game

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("open_menu"):
		emit_signal("pause_game")

func _on_pressed():
	emit_signal("pause_game")
