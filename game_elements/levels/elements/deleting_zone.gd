class_name DeletingArea
extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PolygonView.collision = $CollisionPolygon2D


func _on_body_entered(body: Node2D) -> void:
	print("Ha entrado algo en la zona")
	if body.is_in_group("Piece"):
		print("Entro una pieza")
		body.queue_free()
