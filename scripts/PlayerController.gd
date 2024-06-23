class_name PlayerController
extends Node3D


var _spawn_pos : Vector3
var _spawn_rot : Vector3

@onready var player_cam : PhantomCamera3D = $PlayerCam
@onready var cam_target : Node3D = $CamTarget

@export var player_scene : PackedScene
@export var statue_scene : PackedScene
@export var new_knight_panel : Control

@export var player : CharacterBody3D


func _enter_tree():
	Global.set_player_controller(self)
	new_knight_panel.visible = false


func _exit_tree():
	Global.set_player_controller(null)


func _process(_delta) -> void:
	if OS.has_feature("editor"):
		if Input.is_action_just_pressed("debug_spawn_character"):
			spawn_and_possess_character()
	
	if player != null:
		player.move(get_input_vector())
		
		if Input.is_action_just_pressed("jump"):
			player.jump()
		
		cam_target.global_position = player.global_position


func set_spawn_point(pos: Vector3, rot: Vector3) -> void:
	_spawn_pos = pos
	_spawn_rot = rot


func possess_character(character: PlayerCharacter):
	player = character


func release_character(character: PlayerCharacter):
	if player == character:
		player = null


func spawn_statue_at(pos: Vector3, rot: Vector3):
	var statue = statue_scene.instantiate()
	get_tree().current_scene.add_child(statue)
	statue.global_position = pos
	statue.global_rotation = rot


func spawn_and_possess_character(delay: float = 0.0):
	await get_tree().create_timer(delay).timeout
	
	player = player_scene.instantiate()
	add_child(player)
	player.global_position = _spawn_pos
	player.global_rotation = _spawn_rot


func get_input_vector() -> Vector3:
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var cam_basis_x = normalize_on_plane_xz(player_cam.transform.basis.x)
	var cam_basis_z = normalize_on_plane_xz(player_cam.transform.basis.z)
	return cam_basis_x * input_dir.x + cam_basis_z * input_dir.y


func normalize_on_plane_xz(v: Vector3) -> Vector3:
	v.y = 0.0
	return v.normalized()
