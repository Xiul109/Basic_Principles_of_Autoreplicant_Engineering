extends PanelContainer

const PieceButton = preload("res://UI/piece_button.tscn")

signal piece_selected(piece: PackedScene, is_arrow : bool)

var total_pieces : Array[LevelPieces] : set = _set_total_pieces
var available_pieces : Array[LevelPieces]
var buttons := []

@onready var pieces_container = $pieces_container

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


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
	if piece.count <= 0:
		buttons[i].disabled = true
	piece_selected.emit(piece.piece_type, false)
