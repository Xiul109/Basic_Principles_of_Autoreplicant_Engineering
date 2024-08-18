class_name Piece
extends RigidBody2D

@export var icon : Texture2D
@export var replica_arrows : Array[ReplicaArrow]

@onready var shape := $shape


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Piece")
	shape.polygon = $collision.polygon


func _on_replica_arrows_child_entered_tree(node: Node):
	if node is ReplicaArrow:
		replica_arrows.append(node)


func _on_replica_arrows_child_exiting_tree(node):
	if node in replica_arrows:
		replica_arrows.erase(node)
