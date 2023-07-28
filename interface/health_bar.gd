extends PanelContainer

class_name HealthBar

var last_heart: Control

func _ready():
	pass

func _process(delta):
	pass

func remove_heart(index):
	last_heart = $Margin/HBox.get_child(index)
	$AnimationTimer.start()

func _on_animation_timer_timeout():
	last_heart.visible = not last_heart.visible

func stop_animation():
	$AnimationTimer.stop()
	last_heart.visible = false
