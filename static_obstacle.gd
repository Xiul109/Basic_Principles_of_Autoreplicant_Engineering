class_name StaticObstacle
extends StaticBody2D


@onready var sprite : Sprite2D = $".."




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	define_solid_area()




func define_solid_area() -> void:
	var bitmap=BitMap.new()
	bitmap.create_from_image_alpha(sprite.texture.get_image())
	print("Tamaño original: "+str(sprite.texture.get_size()))
	var zone_size:=Vector2(sprite.texture.get_height(),sprite.texture.get_width()) * sprite.transform.get_scale()
	print("Tamaño zonesize tespues de multiplicar por: "+str(sprite.transform.get_scale()) + "Tamaño final::::: "+str(zone_size))
	var polygons = bitmap.opaque_to_polygons(Rect2(Vector2.ZERO,zone_size))

	
	for poly in polygons:
		var col_polygon=CollisionPolygon2D.new()
		col_polygon.polygon=poly
		add_child(col_polygon)
		#col_polygon.scale=(sprite.transform.get_scale())
		if sprite.centered:
			#col_polygon.position=sprite.position
			col_polygon.position-=Vector2(bitmap.get_size()/2)
