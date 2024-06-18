extends Node


@export var outline_mat : Material

@export_group("Scene Management")
@export var menu_scene_path : String
@export var game_scene_path : String


func load_menu_scene():
	load_scene(menu_scene_path)

func load_game_scene():
	load_scene(game_scene_path)

func load_scene(path : String):
	get_tree().change_scene_to_file(path)
