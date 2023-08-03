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

@onready var text = $PanelContainer/VBoxContainer/ScrollContainer/RichTextLabel as RichTextLabel

func _ready():
	text.push_paragraph(HORIZONTAL_ALIGNMENT_CENTER)
	text.push_bold()
	text.push_font_size(20)
	text.append_text("CONTROLS\n")
	text.pop()
	text.pop()
	text.push_table(2)
	for act in ACTIONS:
		text.push_cell()
		text.append_text(ACTIONS.get(act))
		text.pop()
		text.push_cell()
		for ev in InputMap.action_get_events(act):
			text.append_text(ev.as_text() + "\n")
		text.pop()

func _on_ok_button_pressed():
	get_tree().change_scene_to_file("res://interface/main_menu.tscn")
