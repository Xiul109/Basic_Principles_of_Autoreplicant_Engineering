extends Control

@onready var replicant_editor := $ReplicantEditor

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
	var replicant := level.replicant
	replicant.mode = Replicant.Mode.DEFAULT
	level.timer.start()
	
