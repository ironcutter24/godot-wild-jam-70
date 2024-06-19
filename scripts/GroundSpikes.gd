extends MouseInteractive


const SPIKE_DURATION = 1.2

var is_cooldown = false

@onready var spike_area : Area3D = $Area3D


func _ready() -> void:
	set_spikes(false)


func interact_left() -> void:
	super.interact_left()
	
	if not is_cooldown:
		set_spikes(true)
		await get_tree().create_timer(SPIKE_DURATION).timeout
		set_spikes(false)


func set_spikes(state : bool) -> void:
	is_cooldown = state
	spike_area.monitoring = state


func _on_area_3d_body_entered(body):
	if body is PlayerCharacter:
		body.death()
