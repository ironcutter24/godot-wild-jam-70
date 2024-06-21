class_name PlayerAnimation
extends AnimationTree


@onready var _bored_timer = $BoredTimer

@export var _is_moving : bool = false
@export var _is_bored_trigger : bool = false
@export var _is_hurt_trigger : bool = false

@export var _is_in_air : bool = false
@export var _is_falling : bool = false

@export_group("Params")
@export var _bored_start_delay : float = 4.0
@export var _bored_loop_delay : float = 10.0


func _ready():
	active = true


func set_move(state: bool):
	_is_moving = state


func set_jump(is_on_floor: bool, v_speed: float):
	_is_in_air = not is_on_floor
	_is_falling = v_speed < 0.0


func set_hurt_trigger():
	_is_hurt_trigger = true
	await _trigger_deadzone_async()
	_is_hurt_trigger = false


func reset_bored_timer():
	_bored_timer.start(_bored_start_delay)


func _on_bored_timer_timeout():
	_bored_timer.start(_bored_loop_delay)
	
	_is_bored_trigger = true
	await _trigger_deadzone_async()
	_is_bored_trigger = false


func _trigger_deadzone_async():
	await get_tree().create_timer(0.1).timeout
