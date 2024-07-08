class_name GameEndingVolume
extends Area3D


var game_over : bool = false


func _ready() -> void:
	visible = false
	
	body_entered.connect(_body_changed)
	body_exited.connect(_body_changed)


func _body_changed(_body) -> void:
	for body in get_overlapping_bodies():
		if body is PlayerStatue:
			_start_game_ending()
			return


func _start_game_ending() -> void:
	Global.set_game_over()
	await get_tree().create_timer(2.0).timeout
	Global.reset_and_load_first_scene()
