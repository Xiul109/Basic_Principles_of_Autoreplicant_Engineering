class_name StaticObstacle
extends StaticBody2D

func _ready():
	$PolygonView.collision = $CollisionPolygon2D
