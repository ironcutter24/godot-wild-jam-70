class_name PressurePlate
extends Area3D


func is_pressed() -> bool:
	return get_overlapping_bodies().size() > 0
