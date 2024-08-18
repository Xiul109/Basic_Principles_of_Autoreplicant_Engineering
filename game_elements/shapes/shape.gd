class_name Piece
extends RigidBody2D

@export var icon : Texture2D
@export var replica_arrows : Array[ReplicaArrow]
@export var border_width : float = 4

@onready var shape := $shape

# Called when the node enters the scene tree for the first time.
func _ready():
	shape.polygon = $collision.polygon
	var inner_pol : PackedVector2Array = shape.polygon.duplicate()
	for i in len(inner_pol):
		
		inner_pol[i] *= .9
	$shape/inner_shape.polygon = inner_pol


func _on_replica_arrows_child_entered_tree(node: Node):
	if node is ReplicaArrow:
		replica_arrows.append(node)


func _on_replica_arrows_child_exiting_tree(node):
	if node in replica_arrows:
		replica_arrows.erase(node)


func _on_placer_mode_changed(mode):
	if mode in [Replicant.Mode.EDITION, Replicant.Mode.PLACED]:
		freeze = true
	else:
		freeze = false
