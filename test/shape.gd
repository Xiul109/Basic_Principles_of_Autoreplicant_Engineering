extends RigidBody2D

const Shape = preload("res://test/shape.tscn")
@onready var timer := $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start()
	print(rad_to_deg(($RayCast2D.target_position - $RayCast2D.position).angle()))
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_timer_timeout():
	var new_shape := duplicate()
	new_shape.global_position = $RayCast2D.global_position
	new_shape.global_rotation = ($RayCast2D.target_position - $RayCast2D.position).angle() + global_rotation
	print(new_shape.global_position, " ", new_shape.global_rotation_degrees)
	print(new_shape.get_children())
	new_shape.get_child(2).start()

	get_parent().add_child(new_shape)
