class_name PressurePlate
extends Area3D


signal state_changed

var _is_pressed = false

@export var _is_inverted = false


func _ready() -> void:
	body_entered.connect(_body_changed)
	body_exited.connect(_body_changed)


func is_pressed() -> bool:
	if _is_inverted:
		return not _is_pressed
	else:
		return _is_pressed


func _can_be_released() -> bool:
	return true


func _body_changed(_body) -> void:
	_refresh_is_pressed()


func _refresh_is_pressed() -> void:
	if _is_pressed and not _can_be_released():
		return
	
	if _refresh_and_get_state_changed():
		state_changed.emit()  # Notify state change to doors
		_play_sound()


func _refresh_and_get_state_changed() -> bool:
	var was_pressed = _is_pressed
	_is_pressed = get_overlapping_bodies().size() > 0
	return _is_pressed != was_pressed


func _play_sound() -> void:
	($PressSound if _is_pressed else $ReleaseSound).play()
