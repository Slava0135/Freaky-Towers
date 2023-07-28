extends PanelContainer

class_name HealthBar

func _ready():
	pass

func _process(delta):
	pass

func remove_heart(index):
	$Margin/HBox.get_child(index).visible = false
