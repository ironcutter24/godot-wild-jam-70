extends Node


var _player_controller : PlayerController
var _level_index : int = 0

@onready var _theme_audio = $ThemeAudio

@export_category("Scene Management")
@export var _level_list : Array[String]

@export_category("Managers")
@export var Audio : AudioManager

@export_group("Global Assets")
@export var _outline_mat : Material


func _input(event: InputEvent):
	if OS.has_feature("editor"):
		if event.is_action_pressed("debug_next_level"):
			load_next_scene()
	
	if event.is_action_pressed("quit_game"):
		get_tree().quit()


func load_next_scene():
	_level_index += 1
	print(str("Loading level: ", _level_index))
	
	if _level_index >= _level_list.size():
		_level_index = 0
	
	if _level_index == 2:
		# Start theme music
		set_theme_music(true)
	elif _level_index == 0:
		# Stop level music
		set_theme_music(false)
	
	_load_scene(_level_list[_level_index])

func reload_current_scene():
	_load_scene(_level_list[_level_index])

func _load_scene(path : String):
	get_tree().change_scene_to_file(path)


func get_player_controller() -> PlayerController:
	return _player_controller

func set_player_controller(controller: PlayerController) -> void:
	_player_controller = controller

func get_outline_mat() -> Material:
	return _outline_mat


func set_theme_music(state: bool) -> void:
	if state:
		_theme_audio.play()
	else:
		_theme_audio.stop()
