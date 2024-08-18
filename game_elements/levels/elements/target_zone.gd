class_name TargetArea
extends Area2D

func _ready():
	$PolygonView.collision = $CollisionPolygon2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Piece"):
		print("VICOTIRAAA LLEGASSTE AL AREA")
		SignalBus.game_won.emit()
