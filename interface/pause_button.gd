extends Button

signal pause_game

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		pause_game.emit()

func _on_pressed():
	pause_game.emit()
