class_name Level
extends Node2D

@export var pieces : Array[LevelPieces]
@export var n_arrows : int = 0

@onready var building_area: Area2D = $building_area

@onready var base_replicant : Replicant = $BaseReplicant
@onready var timer = $Timer

@onready var replicants_node = $replicants
var active_replicants : Array[Replicant]

var previews : Array[Replicant]

var playing := false

func _process(_delta):
	if playing:
		return
	# This approach is very unefficient but works by the moment
	update_previews()

func update_previews():
	clean_previews()
	
	for arrow in base_replicant.arrows:
		var preview = base_replicant.duplicate(4)
		add_child(preview)
		preview.mode = Replicant.Mode.PREVIEW
		preview.update_pos_from_arrow(arrow)
		previews.append(preview)

func clean_previews():
	for pre in previews:
		pre.queue_free()
	previews.clear()

func clean_replicants():
	active_replicants.clear()
	for repli in $replicants.get_children():
		repli.queue_free()


func _on_timer_timeout():
	var new_replicants : Array[Replicant]
	for repli in active_replicants:
		new_replicants.append_array(repli.replicate())
	for repli in new_replicants:
		replicants_node.add_child(repli)
	active_replicants = new_replicants
