extends Polygon2D

@export var collision : CollisionPolygon2D : set=_collision_set
@export var border_width : float = 4

@onready var inner_shape = $InnerShape

func _ready():
	update_view()

# Called when the node enters the scene tree for the first time.
func _collision_set(new_collision : CollisionPolygon2D):
	collision = new_collision
	update_view()

func update_view():
	if collision == null:
		return
	polygon = collision.polygon
	var inner_pol : PackedVector2Array = polygon.duplicate()
	for i in len(inner_pol):
		var v : Vector2 = polygon[i] - polygon[(i + 1)%len(inner_pol)]
		var offset_dir = v.orthogonal().normalized()
		inner_pol[i] += offset_dir * border_width
		inner_pol[(i + 1)%len(inner_pol)] += offset_dir * border_width
	inner_shape.polygon = inner_pol
