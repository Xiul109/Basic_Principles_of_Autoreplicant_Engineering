class_name ReplicaArrow
extends RayCast2D

@onready var icon = $icon.texture

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_placer_mode_changed(new_mode):
	if new_mode == Replicant.Mode.PLACED and $placer.closest_object != null:
		reparent($placer.closest_object)
