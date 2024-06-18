class_name MouseInteractive
extends Node3D


@export var mesh_instance : MeshInstance3D


#func _ready():
	#mouse_enter()

func mouse_enter() -> void:
	mesh_instance.material_overlay = Global.outline_mat


func mouse_exit() -> void:
	mesh_instance.material_overlay = null


func interact_left() -> void:
	print(str("Clicked (left): ", name))


func interact_right() -> void:
	print(str("Clicked (right): ", name))
