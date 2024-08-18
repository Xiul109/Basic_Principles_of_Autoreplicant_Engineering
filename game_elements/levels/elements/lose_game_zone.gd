class_name LoseGameArea
extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PolygonView.collision = $CollisionPolygon2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Piece"):
		print("AAA wey perdiste")
		SignalBus.game_lost.emit()
