extends Node2D

@onready var timer = $Timer
@onready var replicas = $replicas

@export var base_replicant : Replicant

var active_replicants : Array[Replicant]


# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start()
	active_replicants.append(base_replicant)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var body = $replicas/RigidBody2D
	print(body.position, " - ", body.global_position)


func _on_timer_timeout():
	pass
	#var new_replicants : Array[Replicant]
	#for replicant in active_replicants:
		#new_replicants.append_array(replicant.replicate())
	#active_replicants = new_replicants
