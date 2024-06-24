class_name PressurePlate
extends Area3D


var _is_pressed = false


func _ready():
	body_entered.connect(_body_changed)
	body_exited.connect(_body_changed)


func is_pressed() -> bool:
	return _is_pressed


func _body_changed(_body) -> void:
	_refresh_is_pressed()


func _refresh_is_pressed() -> void:
	var _was_pressed = _is_pressed
	_is_pressed = get_overlapping_bodies().size() > 0
	if _is_pressed != _was_pressed:
		if _is_pressed:
			$PressSound.play()
		else:
			$ReleaseSound.play()
