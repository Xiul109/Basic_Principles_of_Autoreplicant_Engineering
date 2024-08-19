class_name Replicant
extends Node2D

enum Mode {DEFAULT, PLACED, EDITION, PREVIEW}

@export var pieces : Array[Piece]
@export var mode : Mode = Mode.EDITION : set=_mode_set

var arrows : Array[ReplicaArrow]

func replicate(rep_mode: Mode = Mode.DEFAULT) -> Array[Replicant]:
	var replicas : Array[Replicant] = []
	for piece in pieces:
		for arrow in piece.replica_arrows:
			var replica := duplicate(4)
			replica.mode = rep_mode
			replica.update_pos_from_arrow(arrow)
			replicas.append(replica)
	return replicas

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


func _on_child_entered_tree(node):
	if node is Piece:
		pieces.append(node)
		node.arrow_added.connect(func(arrow: ReplicaArrow): arrows.append(arrow))
		node.arrow_deleted.connect(func(arrow: ReplicaArrow): arrows.erase(arrow))
	if node is ReplicaArrow:
		arrows.append(node)

func _on_child_exiting_tree(node):
	if node is Piece and node in pieces:
		pieces.erase(node)
	
	if node is ReplicaArrow:
		arrows.erase(node)
