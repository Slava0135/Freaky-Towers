class_name Scores

const FILE_NAME = "user://scores.cfg"

var scores = ConfigFile.new()
var best_score = 0

func _init():
	var err = scores.load(FILE_NAME)
	if err != null:
		best_score = scores.get_value("survival", "score", 0)

func update_score(score: int):
	best_score = max(score, best_score)
	scores.set_value("survival", "score", best_score)
	scores.save(FILE_NAME)
