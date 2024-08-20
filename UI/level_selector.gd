extends Control

const START_LEVEL_BUTTON = preload("res://UI/StartLevelButton.tscn")

@onready var grid_container = %level_container

@export var levels : Array[PackedScene]
@export var won_color := Color(.3, .8, .4)

var level_selected_i : int

var _levels_state : Array[bool]
var _buttons : Array[Button]

signal level_selected(level: PackedScene)

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in len(levels):
		var level = levels[i]
		if level == null:
			continue
		var button = START_LEVEL_BUTTON.instantiate()
		button.text = "Level %d"%(i+1)
		# Sending the signal to other node
		button.pressed.connect(
			func(): 
				level_selected.emit(level)
				level_selected_i = i
		)
		grid_container.add_child(button)
		_buttons.append(button)
		_levels_state.append(false)

func set_level_state(i: int, won: bool):
	_levels_state[i] = won
	var color = won_color if won else Color.WHITE
	_buttons[i].modulate = color
