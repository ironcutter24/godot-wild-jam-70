extends MouseInteractive


const LAUNCH_FORCE = 20.0

@export var arrow_scene : PackedScene
@export var spawn_points : Array[Node3D]


func interact_left() -> void:
	super.interact_left()
	shoot()


func shoot() -> void:
	for p in spawn_points:
		launch_dart(p)


func launch_dart(point : Node3D):
	var arrow : RigidBody3D = arrow_scene.instantiate()
	add_child(arrow)
	arrow.global_position = point.global_position
	arrow.global_rotation = point.global_rotation
	arrow.apply_central_impulse(transform.basis.z * LAUNCH_FORCE)
