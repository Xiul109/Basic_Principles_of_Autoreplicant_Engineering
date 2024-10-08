class_name Replicant
extends Node2D

enum Mode {DEFAULT, PLACED, EDITION, PREVIEW}

const REPLICANT = preload("res://game_elements/replicant.tscn")

@export var pieces : Array[Piece]
@export var mode : Mode = Mode.EDITION : set=_mode_set
@export var active_color := Color(.9, .3, .3)

#@onready var pieces_node = $pieces

var arrows : Array[ReplicaArrow]

func _process(_delta):
	for i in len(pieces):
		$Line2D.points[i] = pieces[i].position
	
	#if mode != Mode.DEFAULT:
	$origin.position = _find_mean_point()
	

func replicate(rep_mode: Mode = Mode.DEFAULT) -> Array[Replicant]:
	var replicas : Array[Replicant] = []
	
	modulate = Color.WHITE
	
	if len(arrows)==0 or are_there_null_arrows():
		print("Ninguna flecha en la iteracion")
		SignalBus.game_lost.emit("no_pieces")
		return []
	
	for arrow in arrows:
		var replica := duplicate(7)
		#var replica := _create_replica()
		replica.mode = rep_mode
		replica.update_pos_from_arrow(arrow)
		replica._delete_pieces_velocity()
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
	global_rotation = arrow.global_rotation
	global_position += arrow.global_position - $origin.global_position

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

func add_arrow(arrow):
	if arrow is ReplicaArrow and arrow not in arrows:
		arrows.append(arrow)

func _on_child_entered_tree(node):
	if node is Piece and node not in pieces:
		pieces.append(node)
		$Line2D.add_point(node.position)
		node.arrow_added.connect(add_arrow)
		node.arrow_deleted.connect(func(arrow: ReplicaArrow): arrows.erase(arrow))
	add_arrow(node)

func _on_child_exiting_tree(node):
	if node is Piece and node in pieces:
		var i = pieces.find(node)
		pieces.pop_at(i)
		$Line2D.remove_point(i)
	
	if node is ReplicaArrow:
		arrows.erase(node)

func _find_mean_point() -> Vector2:
	var mean_point := Vector2.ZERO
	if len(pieces) <= 0:
		return mean_point
	
	for piece in pieces:
		mean_point += piece.position
	return mean_point / len(pieces)

func _move_pieces(offset : Vector2):
	for piece in pieces:
		piece.position += offset
	position -= offset

func _delete_pieces_velocity():
	for piece in pieces:
		piece.linear_velocity = Vector2.ZERO
