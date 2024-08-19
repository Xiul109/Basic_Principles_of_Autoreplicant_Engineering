class_name DeletingArea
extends Area2D

var active:=false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PolygonView.collision = $CollisionPolygon2D
	SignalBus.connect("activate_delete_areas",activate_area)


func activate_area(value:bool):
	active=value

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Piece") and active:
		body.queue_free()
