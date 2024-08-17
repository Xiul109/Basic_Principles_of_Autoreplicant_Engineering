class_name Replicant
extends Node2D

@export var pieces : Array[Piece]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func replicate() -> Array[Replicant]:
	var replicas : Array[Replicant] = []
	for piece in pieces:
		for arrow in piece.replica_arrows:
			var replica := duplicate()
			replica.global_position = arrow.global_position
			replica.global_rotation = \
				piece.global_rotation + \
				(arrow.target_position - arrow.position).angle() \
				+ PI/2 # This is added, because the intuition is that up arrow is considered no rotation

			get_parent().add_child(replica)
			replicas.append(replica)
	return replicas
