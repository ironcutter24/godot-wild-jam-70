extends Node3D


@export var point : Node3D


func _on_area_3d_body_entered(body):
	if body is PlayerCharacter:
		get_node("%PlayerController").set_spawn_point(point)
