class_name Placer
extends Node

enum MovementType {PIECE, ARROW}

const rotation_speed := 2*PI/4

var _mouse_in = false
var _rotation_dir = 0

var parent
var closest_object = null
var button_index = 0

var mode : Replicant.Mode :
	set(new_mode):
		mode = new_mode
		mode_changed.emit(new_mode)

@export var movement_type: MovementType

signal mode_changed(new_mode)
signal deleted(button_index: int)

func _ready():
	parent = get_parent()

func _process(delta):
	if mode != Replicant.Mode.EDITION:
		return
	
	_edition_process(delta)


func _edition_process(delta):
	var new_position = parent.get_global_mouse_position()
	if movement_type == MovementType.ARROW:
		var aux_pos := _find_snap_point(new_position)
		if aux_pos != Vector2.INF:
			new_position = aux_pos
	parent.global_position = new_position
	if Input.is_action_pressed("piece_rotation_clockwise"):
		_rotation_dir = -1
	elif Input.is_action_pressed("piece_rotation_counter_clockwise"):
		_rotation_dir = 1
	else:
		_rotation_dir = 0

	parent.rotate(_rotation_dir * rotation_speed * delta)

func _find_snap_point(ref_pos: Vector2) -> Vector2:
	var closest_point := Vector2.INF
	var best_dist := INF
	for piece in get_tree().get_nodes_in_group("piece"):
		var poly = piece.shape.polygon
		for i in len(poly):
			var s1 = poly[i].rotated(piece.global_rotation) + piece.global_position
			var s2 = poly[(i+1)%len(poly)].rotated(piece.global_rotation)  + piece.global_position
			var p = Geometry2D.get_closest_point_to_segment(ref_pos, s1, s2)
			var d = (ref_pos - p).length()
			
			if d < best_dist:
				best_dist = d
				closest_point = p
				closest_object = piece

	return closest_point

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if mode == Replicant.Mode.PLACED:
			mode = Replicant.Mode.EDITION

func _input(event):
	if event is not InputEventMouseButton:
		return
	
	if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if mode == Replicant.Mode.EDITION:
			mode = Replicant.Mode.PLACED
		elif mode == Replicant.Mode.PLACED and _mouse_in:
			mode = Replicant.Mode.EDITION
	
	elif event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		if mode == Replicant.Mode.EDITION or \
		  (mode == Replicant.Mode.PLACED and _mouse_in):
			delete()

func delete():
	for placer in parent.find_children("*", "Placer", true, false):
		if placer != self:
			placer.delete()
	deleted.emit(button_index)
	parent.queue_free()

func _on_mouse_entered():
	_mouse_in = true


func _on_mouse_exited():
	_mouse_in = false
