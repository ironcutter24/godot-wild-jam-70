extends Node3D


func _on_area_3d_body_entered(body):
	if body is PlayerCharacter:
		print("Setting checkpoint...")
		Global.get_player_controller().set_spawn_point(global_position, global_rotation)
