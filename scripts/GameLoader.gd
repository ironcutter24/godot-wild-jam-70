extends Control


const INPUT_ACTIVATION_DELAY = 1.0

var _can_skip : bool = false


func _ready():
	await get_tree().create_timer(INPUT_ACTIVATION_DELAY).timeout
	_can_skip = true


func _input(_event):
	if _can_skip:
		if _event is InputEventKey or _event is InputEventMouseButton:
			Global.load_next_scene()
