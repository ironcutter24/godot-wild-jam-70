extends Node3D


func _on_area_3d_body_entered(body):
	if body is PlayerCharacter:
		print("Setting checkpoint...")
		get_node("%PlayerController").set_spawn_point(global_position)
