class_name ReverseGravityObject
extends RigidBody2D

func _ready():
	$PolygonView.collision = $CollisionPolygon2D
