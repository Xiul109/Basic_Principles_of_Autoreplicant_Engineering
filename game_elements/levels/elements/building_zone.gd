class_name BuildingArea
extends Area2D

func _ready():
	$PolygonView.collision = $CollisionPolygon2D

func check_all_pieces_in_area(total_pieces:int) -> bool:
	var pieces_are_in:=true
	var overlapping_pieces:=get_overlapping_bodies()
	if overlapping_pieces.size()!=total_pieces:
		pieces_are_in=false
	print("Me han preguntado por: "+str(total_pieces)+"    Y yo le he dicho: "+str(pieces_are_in)+"   porqtengo estas piezas: "+str(overlapping_pieces))
	return pieces_are_in


func _on_body_entered(body: Node2D) -> void:
	print("He entrado ahora")
	#body.valid_position(true)
	pass # Replace with function body.


func _on_body_exited(body: Node2D) -> void:
	print("He saliddo ahora")
	#body.valid_position(false)
	pass # Replace with function body.
