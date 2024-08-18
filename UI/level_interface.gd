extends Control

@onready var replicant_editor := $ReplicantEditor
var recovery_position : Vector2

@export var level : Level :
	set(new_level):
		level = new_level
		#add_child(level)
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
	
	level.base_replicant.mode = Replicant.Mode.DEFAULT
	var copy_reply = level.base_replicant.duplicate(4)
	level.replicants_node.add_child(copy_reply)
	level.active_replicants.append(copy_reply)
	level.base_replicant.mode = Replicant.Mode.PLACED
	level.base_replicant.hide()
	level.base_replicant.set_physics_process(false)
	recovery_position = level.base_replicant.position
	level.base_replicant.position = Vector2.INF
	
	level.timer.start()
	$PlayButton.hide()
	$StopButton.show()


func _on_stop_button_pressed():
	level.timer.stop()
	level.clean_replicants()
	level.base_replicant.show()
	level.base_replicant.set_physics_process(true)
	level.base_replicant.position = recovery_position
	$PlayButton.show()
	$StopButton.hide()
	
