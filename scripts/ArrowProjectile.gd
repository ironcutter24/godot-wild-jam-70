extends RigidBody3D


var is_enabled = true


func _ready():
	contact_monitor = true
	max_contacts_reported = 1


func _on_body_entered(body):
	if is_enabled and (body.owner != get_parent_node_3d()):
		if body is PlayerCharacter:
			body.death()
		
		is_enabled = false
		call_deferred("set_contact_monitor", false)
