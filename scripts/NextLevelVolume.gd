extends Node3D


func _ready():
	$MeshInstance3D.visible = false


func _on_area_3d_body_entered(body):
	if body is PlayerCharacter:
		body.destroy()
		call_deferred("_load_next")


func _load_next():
	Global.load_next_scene()
