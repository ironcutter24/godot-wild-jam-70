extends Node3D


func _ready():
	visible = false
	var controller = Global.get_player_controller()
	controller.set_spawn_point(global_position, global_rotation)
	controller.spawn_and_possess_character()
