extends Button

@export var level_pieces : LevelPieces : set = _level_pieces_set

var i = 0
signal piece_pressed(i: int)

# Called when the node enters the scene tree for the first time.
func _ready():
	update_button()


func _level_pieces_set(pieces: LevelPieces):
	level_pieces = pieces
	update_button()

func update_button():
	var piece : Piece = level_pieces.piece_type.instantiate()
	icon = piece.icon
	piece.queue_free()
	text = "x%d"%level_pieces.count


func _on_pressed():
	piece_pressed.emit(i)
