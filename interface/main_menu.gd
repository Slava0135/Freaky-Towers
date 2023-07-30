extends Control

var scores = Scores.new()

func _ready():
	$PanelContainer/VBox/Score.text = str(scores.best_score)

func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://games/survival.tscn")
