extends MouseInteractive


const LAUNCH_FORCE = 20.0
const COOLDOWN_DURATION = 0.5

var is_cooldown = false

@onready var audio_player : AudioStreamPlayer = $AudioStreamPlayer

@export var arrow_scene : PackedScene
@export var spawn_points : Array[Node3D]


func interact_left() -> void:
	super.interact_left()
	
	if not is_cooldown:
		is_cooldown = true
		shoot()
		await get_tree().create_timer(COOLDOWN_DURATION).timeout
		is_cooldown = false


func shoot() -> void:
	for p in spawn_points:
		launch_dart(p)
	audio_player.play()


func launch_dart(point: Node3D) -> void:
	var arrow : RigidBody3D = arrow_scene.instantiate()
	add_child(arrow)
	arrow.global_position = point.global_position
	arrow.global_rotation = point.global_rotation
	arrow.apply_central_impulse(transform.basis.z * LAUNCH_FORCE)
