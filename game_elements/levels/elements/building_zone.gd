class_name BuildingArea
extends Area2D

func _ready():
	$PolygonView.collision = $CollisionPolygon2D

func check_all_pieces_in_area(total_pieces:int) -> bool:
	var pieces_are_in:=true
	var overlapping_pieces:=get_overlapping_bodies()
	if overlapping_pieces.size()!=total_pieces:
		pieces_are_in=false
	return pieces_are_in

func _get_placer(body: Node2D) -> Placer:
	var placers = body.find_children("*", "Placer")
	if placers.is_empty():
		return null
	return placers[0]

func _on_body_entered(body: Node2D) -> void:
	var placer := _get_placer(body)
	if placer != null:
		placer.is_in_building_area = true


func _on_body_exited(body: Node2D) -> void:
	var placer := _get_placer(body)
	if placer != null:
		placer.is_in_building_area = false


func _on_area_entered(area):
	var placer := _get_placer(area)
	if placer != null:
		placer.is_in_building_area = true


func _on_area_exited(area):
	var placer := _get_placer(area)
	if placer != null:
		placer.is_in_building_area = true
