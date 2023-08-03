extends Control

const ACTIONS = {
	"move_right" : "Move Right",
	"move_left" : "Move Left",
	"nudge_right" : "Nudge Right",
	"nudge_left" : "Nudge Left",
	"fast_drop" : "Fast Drop",
	"rotate_clockwise" : "Rotate Clockwise",
	"rotate_anticlockwise" : "Rotate Anticlockwise",
}

@onready var text = $VBoxContainer/TabContainer/Controls as RichTextLabel

func _ready():
	text.push_table(2)
	for act in ACTIONS:
		text.push_cell()
		text.append_text(ACTIONS.get(act) + "    ")
		text.pop()
		text.push_cell()
		for ev in InputMap.action_get_events(act):
			text.append_text(ev.as_text() + "\n")
		text.pop()

func _on_ok_button_pressed():
	get_tree().change_scene_to_file("res://interface/main_menu.tscn")
