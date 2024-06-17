extends Node3D


@onready var playerCam : PhantomCamera3D = $PlayerCam
@onready var camTarget : Node3D = $CamTarget

@export var player_scene : PackedScene

@export var player : CharacterBody3D

var index = 0
@export var playerCharacters : Array[CharacterBody3D]


func _process(_delta) -> void:
	if OS.has_feature("editor"):
		if Input.is_action_just_pressed("debug_spawn_character"):
			player = player_scene.instantiate()
			add_child(player)
	
	if player != null:
		player.move(get_input_vector())
		
		if Input.is_action_just_pressed("jump"):
			player.jump()
		
		camTarget.global_position = player.global_position


func get_input_vector() -> Vector3:
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var cam_basis_x = normalize_on_plane_xz(playerCam.transform.basis.x)
	var cam_basis_z = normalize_on_plane_xz(playerCam.transform.basis.z)
	return cam_basis_x * input_dir.x + cam_basis_z * input_dir.y


func normalize_on_plane_xz(v : Vector3) -> Vector3:
	v.y = 0.0
	return v.normalized()
