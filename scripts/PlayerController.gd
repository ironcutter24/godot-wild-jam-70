extends CharacterBody3D


const MOVE_SPEED = 10.0
const LOOK_AT_LERP_SPEED = 0.16

const JUMP_VELOCITY = 12.0
const GRAVITY_JUMP = 32.0
const GRAVITY_FALL = 48.0
const SPEED_LIMIT = 60.0

@export var camera : PhantomCamera3D


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= get_gravity_scale(velocity.y) * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	velocity.y = clamp(velocity.y, -SPEED_LIMIT, SPEED_LIMIT)
	
	# Handle movement.
	var direction = get_input_vector()
	if direction:
		velocity = direction.normalized() * MOVE_SPEED + Vector3.UP * velocity.y
		global_rotation.y = lerp_angle(global_rotation.y, atan2(velocity.x,velocity.z), LOOK_AT_LERP_SPEED)
	else:
		velocity = velocity.move_toward(Vector3.UP * velocity.y, MOVE_SPEED)
	
	move_and_slide()

func get_input_vector():
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var cam_basis_x = normalize_on_plane_xz(camera.transform.basis.x)
	var cam_basis_z = normalize_on_plane_xz(camera.transform.basis.z)
	return cam_basis_x * input_dir.x + cam_basis_z * input_dir.y

func normalize_on_plane_xz(v : Vector3):
	v.y = 0.0
	return v.normalized()

func get_gravity_scale(v_speed : float):
	if v_speed > 0.0:
		return GRAVITY_JUMP
	else:
		return GRAVITY_FALL
