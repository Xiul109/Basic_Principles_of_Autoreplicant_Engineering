class_name Level
extends Node2D

@export var pieces : Array[LevelPieces]
@export var n_arrows : int = 0

@onready var building_area: Area2D = $building_zone/building_area

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func check_if_pieces_in_zone():
	print("Chequeo piezas")
	var pieces_in_zone:=false
	pieces_in_zone = building_area.check_all_pieces_in_area(pieces.size())
	print("pieces in zone: "+str(pieces_in_zone))
