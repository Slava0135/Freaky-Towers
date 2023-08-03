extends Control

var scores = Scores.new()
var gamerules = Gamerules.new()

func _ready():
	$PanelContainer/VBox/Score.text = str(scores.best_score)
	$PlayOptions/FreeModeButton.set_pressed_no_signal(gamerules.easy)

func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://games/survival.tscn")

func _on_credits_button_pressed():
	get_tree().change_scene_to_file("res://interface/credits_menu.tscn")

func _on_free_mode_button_toggled(button_pressed):
	gamerules.update_mode(button_pressed)

func _on_options_button_pressed():
	get_tree().change_scene_to_file("res://interface/options_menu.tscn")
