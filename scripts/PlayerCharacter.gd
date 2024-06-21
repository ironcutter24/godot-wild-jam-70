class_name PlayerCharacter
extends CharacterBody3D


# Movement
const MOVE_SPEED = 8.5
const LOOK_AT_LERP_SPEED = 0.16
const PUSH_FORCE = 2.0

# Jump
const JUMP_VELOCITY = 12.0
const GRAVITY_JUMP = 32.0
const GRAVITY_FALL = 48.0
const SPEED_LIMIT = 60.0

# Mixed params
const SWEAR_IN_DURATION = 1.0
const SWEAR_OUT_DURATION = 0.6
const SPAWN_CHARACTER_DELAY = 0.4

var _move_input : Vector3 = Vector3.ZERO
var _jump_input : bool = false
var _is_dead : bool = false

@onready var _player_anim : PlayerAnimation = $AnimationTree
@onready var _swear_vignette : Node3D = $SwearVignette

@export var _knight_color_mat : Material


func _ready():
	_swear_vignette.scale = Vector3.ZERO
	_knight_color_mat.albedo_color = Color.from_hsv(randf_range(0, 1), 0.56, 1.0)
	_player_anim.set_move(false)


func move(dir: Vector3) -> void:
	dir.y = 0.0
	_move_input = dir


func jump() -> void:
	_jump_input = true


func death() -> void:
	if not _is_dead:
		_is_dead = true
		
		# Detach PlayerController
		get_parent().release_character(self)
		
		var tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_ELASTIC)
		tween.tween_property(_swear_vignette, "scale", Vector3.ONE, SWEAR_IN_DURATION)
		tween.tween_property(_swear_vignette, "scale", Vector3.ZERO, SWEAR_OUT_DURATION)
		tween.tween_callback(func(): _turn_to_statue())
		
		_player_anim.set_hurt_trigger()


func drown() -> void:
	if not _is_dead:
		_is_dead = true
		_spawn_and_control_character()
		queue_free()


func _physics_process(delta) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= _get_gravity_scale(velocity.y) * delta
	
	# Handle jump.
	if _jump_input and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	velocity.y = clamp(velocity.y, -SPEED_LIMIT, SPEED_LIMIT)
	
	# Handle movement.
	if _move_input:
		velocity = _move_input.normalized() * MOVE_SPEED + Vector3.UP * velocity.y
		global_rotation.y = lerp_angle(global_rotation.y, atan2(velocity.x, velocity.z), LOOK_AT_LERP_SPEED)
		_player_anim.set_move(true)
		_player_anim.reset_bored_timer()
	else:
		velocity = velocity.move_toward(Vector3.UP * velocity.y, MOVE_SPEED)
		_player_anim.set_move(false)
	
	_player_anim.set_jump(is_on_floor(), velocity.y)
	
	move_and_slide()
	_reset_inputs()


func _turn_to_statue() -> void:
	get_parent().spawn_statue_at(global_position, global_rotation)
	_spawn_and_control_character(SPAWN_CHARACTER_DELAY)
	queue_free()


func _spawn_and_control_character(delay: float = 0.0) -> void:
	get_parent().spawn_and_possess_character(delay)


func _get_gravity_scale(v_speed: float) -> float:
	return GRAVITY_JUMP if v_speed > 0.0 else GRAVITY_FALL


func _reset_inputs() -> void:
	_move_input = Vector3.ZERO
	_jump_input = false
