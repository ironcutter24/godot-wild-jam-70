class_name PlayerStatue
extends MouseInteractive


@export var broken_statue : PackedScene


func interact_right() -> void:
	super.interact_right()
	print("Destroying statue")
	
	var obj = broken_statue.instantiate()
	get_tree().current_scene.add_child(obj)
	obj.global_position = global_position
	obj.global_rotation = global_rotation
	
	$CollisionShape3D.set_deferred("disabled", true)
	
	await get_tree().physics_frame
	await get_tree().physics_frame
	
	queue_free()
