class_name Replicant
extends Node2D

enum Mode {DEFAULT, PLACED, EDITION, PREVIEW}

@export var pieces : Array[Piece]
@export var mode : Mode = Mode.EDITION : set=_mode_set


func replicate() -> Array[Replicant]:
	var replicas : Array[Replicant] = []
	for piece in pieces:
		for arrow in piece.replica_arrows:
			var replica := duplicate(4)
			replica.global_position = arrow.global_position
			replica.global_rotation = \
				piece.global_rotation + arrow.global_rotation
				# This is added, because the intuition is that up arrow is considered no rotation

			get_parent().add_child(replica)
			replicas.append(replica)
	return replicas

func _mode_set(new_mode: Mode):
	mode = new_mode
	for child in get_children():
		var placers = child.find_children("*", "Placer")
		if len(placers) > 0:
			placers[0].mode = mode


func _on_child_entered_tree(node):
	if node is Piece:
		pieces.append(node)


func _on_child_exiting_tree(node):
	if node is Piece and node in pieces:
		pieces.erase(node)
