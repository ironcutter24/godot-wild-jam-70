extends RigidBody3D


const destroy_timer = 8.0

var is_enabled = true


func _ready():
	contact_monitor = true
	max_contacts_reported = 1


func _on_body_entered(body):
	if is_enabled and (body != get_parent()):
		if body is PlayerCharacter:
			body.death()
		
		is_enabled = false
		call_deferred("set_contact_monitor", false)
		await get_tree().create_timer(destroy_timer).timeout
		queue_free()
