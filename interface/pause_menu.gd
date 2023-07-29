extends PanelContainer

signal continue_game

func _ready():
	pass

func _process(delta):
	pass

func _on_continue_button_pressed():
	get_tree().paused = false
	emit_signal("continue_game")
