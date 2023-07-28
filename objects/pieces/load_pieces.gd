class_name PieceLoad

class PieceData:
	var scene: PackedScene
	var rot_width: Array[float]

	static func create(scene: PackedScene, rot_width: Array[float]) -> PieceData:
		var it = PieceData.new()
		it.scene = scene
		it.rot_width = rot_width
		return it

	func width(rotation: float) -> float:
		return rot_width[roundi(sin(rotation))]

var pieces = [
#		PieceData.create(preload("O.tscn"), [2, 2]),
		PieceData.create(preload("I.tscn"), [1, 4]),
#		PieceData.create(preload("L.tscn"), [2, 3]),
#		PieceData.create(preload("J.tscn"), [2, 3]),
#		PieceData.create(preload("T.tscn"), [3, 2]),
#		PieceData.create(preload("S.tscn"), [3, 2]),
#		PieceData.create(preload("Z.tscn"), [3, 2]),
	]

func random_piece() -> PieceData:
	return pieces.pick_random()

