extends Control

func _ready():
	var file = FileAccess.open("res://attributions.md", FileAccess.READ)
	$PanelContainer/ScrollContainer/Label.text = file.get_as_text()

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://interface/main_menu.tscn")
