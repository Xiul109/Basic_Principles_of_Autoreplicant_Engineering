extends Control

@onready var replicant_editor := $ReplicantEditor
var recovery_position : Vector2

@onready var game_lost_interface: Control = $game_lost_interface
@onready var button_lost_menu: Button = $game_lost_interface/button_menu
@onready var button_retry: Button = $game_lost_interface/button_retry

@onready var game_won_interface: Control = $game_won_interface
@onready var button_next_level: Button = $game_won_interface/button_next_level
@onready var button_won_menu: Button = $game_won_interface/button_menu


@export var level : Level :
	set(new_level):
		level = new_level
		level.name = "level"
		add_child(level)
		move_child(level, 0)
		if replicant_editor != null:
			replicant_editor.level = level


@export_enum("Building","Replicating") var level_state="Building"

@onready var alert_label: Label = $alert_label

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.connect("game_lost",game_lost)
	button_retry.connect("pressed",_on_stop_button_pressed)
	button_lost_menu.connect("pressed",go_to_menu)
	
	SignalBus.connect("game_won",game_won)
	button_next_level.connect("pressed",_on_stop_button_pressed)
	button_won_menu.connect("pressed",go_to_menu)

func game_lost(reason:String):
	if level_state=="Building":
		return
	game_lost_interface.visible=true
	level.timer.stop()


func game_won():
	if level_state=="Building":
		return
	game_won_interface.visible=true
	level.timer.stop()


func go_to_menu():
	pass

func alert(text:String):
	alert_label.visible=true
	alert_label.text=text
	await get_tree().create_timer(5).timeout
	alert_label.visible=false


func _on_play_button_pressed():
	if level == null:
		return
	elif not replicant_editor.pieces_selector.are_all_pieces_placed():
		alert("You need to use all the pieces and arrows.")
		return
		
	SignalBus.activate_delete_areas.emit(true)
	level_state="Replicating"
	# Setting copy 
	level.base_replicant.mode = Replicant.Mode.DEFAULT
	var copy_reply = level.base_replicant.duplicate(5)
	level.replicants_node.add_child(copy_reply)
	copy_reply.fill_arrows()
	copy_reply.modulate = copy_reply.active_color
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
	level.clean_previews()
	level.playing = true
	# Starting timer
	level.timer.start()



func _on_stop_button_pressed():
	level_state="Building"
	SignalBus.activate_delete_areas.emit(false)
	game_lost_interface.visible=false
	game_won_interface.visible=false
	
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
	level.update_previews()
	level.playing = false
