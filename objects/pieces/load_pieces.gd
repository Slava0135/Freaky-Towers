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
		PieceData.create(preload("res://objects/pieces/O.tscn"), [2, 2]),
		PieceData.create(preload("res://objects/pieces/I.tscn"), [1, 4]),
		PieceData.create(preload("res://objects/pieces/L.tscn"), [2, 3]),
		PieceData.create(preload("res://objects/pieces/J.tscn"), [2, 3]),
		PieceData.create(preload("res://objects/pieces/T.tscn"), [3, 2]),
		PieceData.create(preload("res://objects/pieces/S.tscn"), [3, 2]),
		PieceData.create(preload("res://objects/pieces/Z.tscn"), [3, 2]),
	]

func random_piece() -> PieceData:
	return pieces.pick_random()

