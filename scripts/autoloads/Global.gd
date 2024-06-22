extends Node


var _player_controller : PlayerController

@export_category("Scene Management")
@export var _splash_scene_path : String
@export var _game_scene_path : String

@export_group("Global Assets")
@export var _outline_mat : Material


func _input(event: InputEvent):
	if event.is_action_pressed("quit_game"):
		get_tree().quit()


func load_splash_scene():
	load_scene(_splash_scene_path)

func load_game_scene():
	load_scene(_game_scene_path)

func load_scene(path : String):
	get_tree().change_scene_to_file(path)


func get_outline_mat() -> Material:
	return _outline_mat


func get_player_controller() -> PlayerController:
	return _player_controller


func set_player_controller(controller: PlayerController) -> void:
	_player_controller = controller
