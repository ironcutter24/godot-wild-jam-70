class_name MouseInteractive
extends Node3D


@onready var mesh_instance : MeshInstance3D = $MeshInstance3D


func mouse_enter() -> void:
	mesh_instance.material_overlay = Global.outline_mat


func mouse_exit() -> void:
	mesh_instance.material_overlay = null


func interact_left() -> void:
	print(str("Clicked (left): ", name))


func interact_right() -> void:
	print(str("Clicked (right): ", name))
