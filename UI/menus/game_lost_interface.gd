extends Control

@onready var button_retry = %button_retry
@onready var button_menu = %button_menu
@onready var label_text = $Panel/MarginContainer/PanelContainer/VSplitContainer/LabelText

@export var no_pieces_text := "You are out of replicant pieces"
@export var lost_zone_text := "You have hit a forbidden zone"

var reason : String :
	set(new_reason):
		reason = new_reason
		var text = reason
		if reason == "no_pieces":
			text = no_pieces_text
		elif reason == "lost_zone":
			text = lost_zone_text
		label_text.text = "You lost the game!\n%s"%text
