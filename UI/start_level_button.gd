extends Button

var level : PackedScene
var level_number:=0

signal level_selected(level: PackedScene)


func _on_pressed():
	SignalBus.set_current_level.emit(level_number)
	level_selected.emit(level)
