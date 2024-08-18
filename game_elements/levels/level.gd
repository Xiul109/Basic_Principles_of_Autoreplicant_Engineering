class_name Level
extends Node2D

@export var pieces : Array[LevelPieces]
@export var n_arrows : int = 0

@onready var building_area: Area2D = $building_area
@onready var replicant : Replicant = $Replicant
@onready var timer = $Timer

var active_replicants : Array[Replicant]

#func check_if_pieces_in_zone(body: Node2D):
	#print("Chequeo piezas")
	#var pieces_in_zone:=false
	##pieces_in_zone = building_area.check_all_pieces_in_area(pieces.size())
	#print("pieces in zone: "+str(pieces_in_zone))

func _ready():
	active_replicants.append(replicant)

func _on_timer_timeout():
	var new_replicants : Array[Replicant]
	for repli in active_replicants:
		new_replicants.append_array(repli.replicate())
	active_replicants = new_replicants
