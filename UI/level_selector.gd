extends Control

const START_LEVEL_BUTTON = preload("res://UI/StartLevelButton.tscn")

@onready var grid_container = $GridContainer

@export var levels : Array[PackedScene]

signal level_selected(level: PackedScene)

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in len(levels):
		var level = levels[i]
		if level == null:
			continue
		var button = START_LEVEL_BUTTON.instantiate()
		button.text = "Level %d"%(i+1)
		button.level = level
		# Sending the signal to other node
		button.level_selected.connect(
			func(lev: PackedScene): 
				level_selected.emit(lev)
		)
		grid_container.add_child(button) 
