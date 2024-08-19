extends Button

var level : PackedScene

signal level_selected(level: PackedScene)


func _on_pressed():
	level_selected.emit(level)
