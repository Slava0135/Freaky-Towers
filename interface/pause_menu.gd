extends PanelContainer

signal continue_game
signal restart_game
signal leave_game

func _ready():
	pass

func _process(delta):
	pass

func _on_continue_button_pressed():
	get_tree().paused = false
	continue_game.emit()

func _on_restart_button_pressed():
	get_tree().paused = false
	restart_game.emit()

func _on_main_menu_button_pressed():
	get_tree().paused = false
	leave_game.emit()
