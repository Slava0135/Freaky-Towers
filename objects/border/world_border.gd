extends Area2D

signal piece_fell

var effect = preload("res://effects/vanish.tscn")

func _ready():
	pass

func _process(delta):
	pass

func _on_body_entered(body):
	var e = effect.instantiate() as Node2D
	emit_signal("piece_fell")
	add_sibling(e)
	e.position = body.position
	body.queue_free()
