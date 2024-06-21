class_name PressurePlate
extends Area3D


func is_pressed() -> bool:
	print(get_overlapping_areas())
	print(get_overlapping_bodies())
	return get_overlapping_bodies().size() > 0
