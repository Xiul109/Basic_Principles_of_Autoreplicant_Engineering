extends Control

@onready var replicant_editor := $ReplicantEditor
var recovery_position : Vector2

@export var level : Level :
	set(new_level):
		level = new_level
		add_child(level)
		if replicant_editor != null:
			replicant_editor.level = level

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _on_play_button_pressed():
	if level == null:
		return
	elif not replicant_editor.pieces_selector.are_all_pieces_placed():
		return
	# Setting copy 
	level.base_replicant.mode = Replicant.Mode.DEFAULT
	var copy_reply = level.base_replicant.duplicate(4)
	level.replicants_node.add_child(copy_reply)
	level.active_replicants.append(copy_reply)
	# Setting recovery copy
	level.base_replicant.mode = Replicant.Mode.PLACED
	level.base_replicant.hide()
	recovery_position = level.base_replicant.position
	level.base_replicant.position = Vector2.INF
	# Hiding unuseful UI
	$PlayButton.hide()
	$StopButton.show()
	level.building_area.hide()
	# Starting timer
	level.timer.start()




func _on_stop_button_pressed():
	# Stoping timer
	level.timer.stop()
	# Cleaning and recovering replicant
	level.clean_replicants()
	level.base_replicant.show()
	level.base_replicant.position = recovery_position
	# Showing again UI
	$PlayButton.show()
	$StopButton.hide()
	level.building_area.show()
