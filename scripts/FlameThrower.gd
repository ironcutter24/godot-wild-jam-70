extends MouseInteractive


const EMISSION_DURATION = 2.0

@onready var flame_particles : GPUParticles3D = $FlameParticles
@onready var flame_area : Area3D = $FlameParticles/Area3D
@onready var audio_player : AudioStreamPlayer = $AudioStreamPlayer


func _ready() -> void:
	set_flame(false)


func interact_left() -> void:
	super.interact_left()
	
	if not flame_particles.emitting:
		set_flame(true)
		audio_player.play()
		await get_tree().create_timer(EMISSION_DURATION).timeout
		set_flame(false)


func set_flame(state: bool) -> void:
	flame_particles.emitting = state
	flame_area.monitoring = state


func _on_area_3d_body_entered(body):
	if flame_particles.emitting:
		if body is PlayerCharacter:
			body.death()
