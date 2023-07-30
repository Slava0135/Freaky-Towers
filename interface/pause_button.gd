extends Button

signal pause_game

func _on_pressed():
	pause_game.emit()
