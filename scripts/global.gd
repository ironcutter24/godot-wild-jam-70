extends Node


@export var outline_mat : Material

@export_group("Scene Management")
@export var splash_scene_path : String
@export var game_scene_path : String


func _input(event : InputEvent):
	if event.is_action_pressed("quit_game"):
		get_tree().quit()

func load_splash_scene():
	load_scene(splash_scene_path)

func load_game_scene():
	load_scene(game_scene_path)

func load_scene(path : String):
	get_tree().change_scene_to_file(path)
