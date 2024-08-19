extends PanelContainer

const PieceButton = preload("res://UI/piece_button.tscn")

signal piece_selected(piece: PackedScene, index: int)

var total_pieces : Array[LevelPieces] : set = _set_total_pieces
var available_pieces : Array[LevelPieces]
var buttons := []

@onready var pieces_container = $pieces_container


func are_all_pieces_placed() -> bool:
	for piece in available_pieces:
		if piece.count > 0:
			return false
	return true


func _set_total_pieces(pieces : Array[LevelPieces]):
	total_pieces = pieces
	available_pieces = total_pieces.duplicate(true)
	buttons = []
	for i in len(pieces):
		var piece = pieces[i]
		var button = PieceButton.instantiate()
		button.level_pieces = piece
		button.piece_pressed.connect(_piece_button_pressed)
		button.i = i
		pieces_container.add_child(button)
		buttons.append(button)

func _piece_button_pressed(i: int):
	var piece := available_pieces[i]
	piece.count -= 1
	buttons[i].update_button()
	piece_selected.emit(piece.piece_type, i)
