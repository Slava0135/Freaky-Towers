class_name Gamerules

const FILE_NAME = "user://gamerules.cfg"

var gamerules = ConfigFile.new()
var easy: bool

func _init():
	var err = gamerules.load(FILE_NAME)
	if err != null:
		easy = gamerules.get_value("mode", "easy", false)

func update_mode(set_easy: bool):
	easy = set_easy
	gamerules.set_value("mode", "easy", easy)
	gamerules.save(FILE_NAME)
