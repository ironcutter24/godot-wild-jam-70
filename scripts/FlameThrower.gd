extends MouseInteractive


const EMISSION_DURATION = 2.0

@onready var flame_particles : GPUParticles3D = $FlameParticles

func interact_left() -> void:
	super.interact_left()
	
	if not flame_particles.emitting:
		flame_particles.emitting = true
		await get_tree().create_timer(EMISSION_DURATION).timeout
		flame_particles.emitting = false
