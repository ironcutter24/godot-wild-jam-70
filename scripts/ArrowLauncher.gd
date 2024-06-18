extends MouseInteractive


const LAUNCH_FORCE = 20.0

@onready var spawn_point = $SpawnPoint

@export var arrow_scene : PackedScene


func interact_left() -> void:
	super.interact_left()
	shoot()


func shoot() -> void:
	var arrow : RigidBody3D = arrow_scene.instantiate()
	add_child(arrow)
	arrow.global_position = spawn_point.global_position
	arrow.global_rotation = spawn_point.global_rotation
	arrow.apply_central_impulse(transform.basis.z * LAUNCH_FORCE)
