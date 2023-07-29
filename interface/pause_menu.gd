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
	emit_signal("continue_game")

func _on_restart_button_pressed():
	get_tree().paused = false
	emit_signal("restart_game")

func _on_main_menu_button_pressed():
	get_tree().paused = false
	emit_signal("leave_game")
