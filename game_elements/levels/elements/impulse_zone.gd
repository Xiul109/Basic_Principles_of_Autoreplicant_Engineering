class_name ImpulseZone
extends Area2D



var active:=false
@export_enum("UP","DOWN","RIGHT","LEFT") var direction:="UP"
@export var impulse_force:=1000

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PolygonView.collision = $CollisionPolygon2D
	SignalBus.connect("activate_impulse_areas",activate_area)


func activate_area(value:bool):
	active=value

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Piece") and active:
		match direction:
			"UP":
				body.apply_central_impulse(Vector2(0,-impulse_force))
			"DOWN":
				body.apply_central_impulse(Vector2(0,impulse_force))
			"RIGHT":
				body.apply_central_impulse(Vector2(impulse_force,0))
			"LEFT":
				body.apply_central_impulse(Vector2(-impulse_force,0))
