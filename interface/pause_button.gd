extends Button

signal pause_game

func _ready():
	pass

func _process(delta):
	pass

func _on_pressed():
	pause_game.emit()
