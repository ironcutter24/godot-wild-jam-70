extends MouseInteractive


const SPIKE_DURATION = 1.2

var is_cooldown = false

@onready var spike_area : Area3D = $Area3D
@onready var spike_mesh : MeshInstance3D = $MeshInstance3D/Spikes
@onready var audio_player : AudioStreamPlayer = $AudioStreamPlayer


func _ready() -> void:
	set_spikes(false)


func interact_left() -> void:
	super.interact_left()
	
	if not is_cooldown:
		set_spikes(true)
		audio_player.play()
		await get_tree().create_timer(SPIKE_DURATION).timeout
		set_spikes(false)
		audio_player.play()


func set_spikes(state: bool) -> void:
	if state: is_cooldown = true
	spike_area.monitoring = state
	
	var target_pos : Vector3 = Vector3.ZERO if state else Vector3(0.0, -0.2, 0.0)
	var tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(spike_mesh, "position", target_pos, 0.1)
	tween.tween_callback(func(): if not state: is_cooldown = false)


func _on_area_3d_body_entered(body):
	if body is PlayerCharacter:
		body.death()
