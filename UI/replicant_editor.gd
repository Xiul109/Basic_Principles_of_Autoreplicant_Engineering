extends Control

@export var level : Level

@onready var replicant = $Replicant
@onready var pieces_selector = $PieceSelector


# Called when the node enters the scene tree for the first time.
func _ready():
	pieces_selector.total_pieces = level.pieces


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_piece_selector_piece_selected(piece: PackedScene, is_arrow : bool):
	var floating_piece : Piece = piece.instantiate()
	floating_piece.freeze = true
	floating_piece.global_position = get_global_mouse_position()
	replicant.add_child(floating_piece)
