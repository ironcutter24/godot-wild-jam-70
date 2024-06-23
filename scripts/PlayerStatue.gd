extends MouseInteractive


@export var broken_statue : PackedScene


func interact_right() -> void:
	super.interact_right()
	print("Destroying statue")
	
	var obj = broken_statue.instantiate()
	get_tree().current_scene.get_parent().add_child(obj)
	obj.global_position = global_position
	obj.global_rotation = global_rotation
	
	queue_free()
