extends Area2D

var effect = preload("res://effects/vanish.tscn")

func _ready():
	body_entered.connect(remove_body)

func _process(delta):
	pass

func remove_body(body: Node2D):
	var e = effect.instantiate() as Node2D
	add_sibling(e)
	e.position = body.position
	body.queue_free()
