extends Control

const LEVEL_INTERFACE = preload("res://UI/level_interface.tscn")
@onready var level_selector = $CenterContainer/LevelSelector
var level_interface

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.game_won.connect(func(): level_selector.set_level_state(
		level_selector.level_selected_i,
		true
	))
	pass # Replace with function body.



func _on_level_selector_level_selected(level_scene: PackedScene):
	level_selector.hide()
	level_interface = LEVEL_INTERFACE.instantiate()
	level_interface.exit_to_menu.connect(_show_menu)
	add_child(level_interface)
	var level = level_scene.instantiate()
	level_interface.level = level
	
	
func _show_menu():
	if level_interface == null:
		return
	level_interface.queue_free()
	level_selector.show()
