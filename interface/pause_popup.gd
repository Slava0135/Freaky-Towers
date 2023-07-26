extends AcceptDialog

func _ready():
	confirmed.connect(unpause)
	canceled.connect(unpause)

func _process(delta):
	if Input.is_action_pressed("open_menu"):
		show()
		get_tree().paused = true

func unpause():
	get_tree().paused = false
	hide()
