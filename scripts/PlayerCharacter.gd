class_name PlayerCharacter
extends CharacterBody3D


const MOVE_SPEED = 10.0
const LOOK_AT_LERP_SPEED = 0.16
const PUSH_FORCE = 2.0

const JUMP_VELOCITY = 12.0
const GRAVITY_JUMP = 32.0
const GRAVITY_FALL = 48.0
const SPEED_LIMIT = 60.0

var move_input : Vector3 = Vector3.ZERO
var jump_input : bool = false


func death() -> void:
	print("Death!")


func move(dir : Vector3) -> void:
	dir.y = 0.0
	move_input = dir


func jump() -> void:
	jump_input = true


func _physics_process(delta) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= get_gravity_scale(velocity.y) * delta
	
	# Handle jump.
	if jump_input and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	velocity.y = clamp(velocity.y, -SPEED_LIMIT, SPEED_LIMIT)
	
	# Handle movement.
	if move_input:
		velocity = move_input.normalized() * MOVE_SPEED + Vector3.UP * velocity.y
		global_rotation.y = lerp_angle(global_rotation.y, atan2(velocity.x, velocity.z), LOOK_AT_LERP_SPEED)
	else:
		velocity = velocity.move_toward(Vector3.UP * velocity.y, MOVE_SPEED)
	
	move_and_slide()
	
	#for i in get_slide_collision_count():
		#var c = get_slide_collision(i)
		#if c.get_collider() is RigidBody3D:
			#c.get_collider().apply_central_impulse(-c.get_normal() * PUSH_FORCE * move_input.length())
	
	reset_inputs()


func reset_inputs() -> void:
	move_input = Vector3.ZERO
	jump_input = false


func get_gravity_scale(v_speed : float) -> float:
	if v_speed > 0.0:
		return GRAVITY_JUMP
	else:
		return GRAVITY_FALL
