extends Control

const LEVEL_INTERFACE = preload("res://UI/level_interface.tscn")
@onready var level_selector = $CenterContainer/LevelSelector

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_level_selector_level_selected(level_scene: PackedScene):
	level_selector.hide()
	var level_interface = LEVEL_INTERFACE.instantiate()
	var level = level_scene.instantiate()
	level_interface.level = level
	add_child(level_interface)
