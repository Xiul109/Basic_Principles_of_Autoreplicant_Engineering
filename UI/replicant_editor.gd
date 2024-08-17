extends Control

const REPLICA_ARROW = preload("res://game_elements/replica_arrow.tscn")

@export var level : Level

@onready var replicant = $Replicant
@onready var pieces_selector = $PieceSelector


# Called when the node enters the scene tree for the first time.
func _ready():
	var pieces = level.pieces.duplicate()
	if level.n_arrows > 0:
		var arrows = LevelPieces.new()
		arrows.piece_type = REPLICA_ARROW
		arrows.count = level.n_arrows
		pieces.append(arrows)
	pieces_selector.total_pieces = pieces

func _on_piece_selector_piece_selected(piece: PackedScene, button_i : int):
	var floating_piece = piece.instantiate()
	#floating_piece.global_position = get_global_mouse_position()
	var placer : Placer = floating_piece.find_child("placer", false)
	placer.mode = Replicant.Mode.EDITION
	placer.button_index = button_i
	placer.deleted.connect(_on_piece_deleted)
	replicant.add_child(floating_piece)

func _on_piece_deleted(i: int):
	pieces_selector.available_pieces[i].count += 1
	pieces_selector.buttons[i].update_button()
