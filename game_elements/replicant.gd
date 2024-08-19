class_name Replicant
extends Node2D

enum Mode {DEFAULT, PLACED, EDITION, PREVIEW}

@export var pieces : Array[Piece]
@export var mode : Mode = Mode.EDITION : set=_mode_set
@export var active_color := Color(.9, .3, .3)

var arrows : Array[ReplicaArrow]

	
func replicate(rep_mode: Mode = Mode.DEFAULT) -> Array[Replicant]:
	var replicas : Array[Replicant] = []
	
	modulate = Color.WHITE
	
	if len(arrows)==0 or are_there_null_arrows():
		print("Ninguna flecha en la iteracion")
		SignalBus.game_lost.emit("no_pieces")
		return []
	
	for arrow in arrows:
		var replica := duplicate(5)
		replica.mode = rep_mode
		replica.update_pos_from_arrow(arrow)
		replica.fill_arrows()
		replicas.append(replica)
		replica.modulate = active_color
	
	return replicas

func are_there_null_arrows():
	for arrow in arrows:
		if arrow == null:
			return true
	return false

func update_pos_from_arrow(arrow: ReplicaArrow):
	global_position = arrow.global_position
	global_rotation = arrow.global_rotation

func _mode_set(new_mode: Mode):
	mode = new_mode
	for child in get_children():
		var placers = child.find_children("*", "Placer")
		if len(placers) > 0:
			placers[0].mode = mode
	if mode == Mode.PREVIEW:
		modulate = Color(.3, .3, .3, .4)
	if mode != Mode.DEFAULT:
		$origin.show()
	else:
		$origin.hide()

func fill_arrows():
	for piece in pieces:
		arrows.append_array(piece.replica_arrows)

func _on_child_entered_tree(node):
	if node is Piece and node not in pieces:
		pieces.append(node)
		node.arrow_added.connect(add_arrow)
		node.arrow_deleted.connect(func(arrow: ReplicaArrow): arrows.erase(arrow))
	add_arrow(node)

func add_arrow(arrow):
	if arrow is ReplicaArrow and arrow not in arrows:
		arrows.append(arrow)

func _on_child_exiting_tree(node):
	if node is Piece and node in pieces:
		pieces.erase(node)
	
	if node is ReplicaArrow:
		arrows.erase(node)
