class_name PressurePlate
extends Area3D

var _was_pressed = false


func is_pressed() -> bool:
	var _is_pressed = get_overlapping_bodies().size() > 0
	if _is_pressed != _was_pressed:
		if _is_pressed:
			$PressSound.play()
		else:
			$ReleaseSound.play()
	
	_was_pressed = _is_pressed
	return _is_pressed
