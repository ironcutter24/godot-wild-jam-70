extends StaticBody3D


var _is_open : bool = false

@export var _pressure_plates : Array[PressurePlate]
@export var _all_required : bool = false
@export var _stay_open : bool = false


func _ready():
	if not _pressure_plates:
		push_warning("No pressure plate assigned to door")


func _physics_process(_delta):
	if not _stay_open or not _is_open:
		var should_open = _are_all_pressed() if _all_required else _are_any_pressed()
		if should_open != _is_open:
			_set_open(should_open)


func _are_any_pressed() -> bool:
	for plate in _pressure_plates:
		if plate and plate.is_pressed():
			return true
	return false


func _are_all_pressed() -> bool:
	for plate in _pressure_plates:
		if plate and not plate.is_pressed():
			return false
	return true


func _set_open(state: bool) -> void:
	_is_open = state
	$CollisionShape3D.disabled = state
	
	var tween_left = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_SINE)
	tween_left.tween_property($Doors/MeshLeft, "rotation_degrees", Vector3(0.0, 80.0 if state else 0.0, 0.0), 1)
	
	var tween_right = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_SINE)
	tween_right.tween_property($Doors/MeshRight, "rotation_degrees", Vector3(-180.0, -80.0 if state else 0.0, 0.0), 1)
