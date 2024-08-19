class_name Piece
extends RigidBody2D

@export var icon : Texture2D
@export var replica_arrows : Array[ReplicaArrow]

@onready var shape := $shape

signal arrow_added(arrow: ReplicaArrow)
signal arrow_deleted(arrow: ReplicaArrow)

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Piece")
	shape.collision = $collision


func _on_replica_arrows_child_entered_tree(node: Node):
	if node is ReplicaArrow and node not in replica_arrows:
		replica_arrows.append(node)
		arrow_added.emit(node)


func _on_replica_arrows_child_exiting_tree(node):
	if node in replica_arrows:
		arrow_deleted.emit(node)
		replica_arrows.erase(node)


func _on_placer_mode_changed(mode):
	# Checking if freezing
	if mode == Replicant.Mode.DEFAULT:
		freeze = false
	else:
		freeze = true
	# Checking visual aspect
	#if mode == 
