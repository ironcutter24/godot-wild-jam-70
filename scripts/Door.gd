extends StaticBody3D


var _is_open : bool = false

@onready var _door_mesh : MeshInstance3D = $MeshInstance3D/DoorMesh

@export var _pressure_plates : Array[PressurePlate]
@export var _all_required : bool = false
@export var _stay_open : bool = false


func _physics_process(_delta):
	if not _stay_open or not _is_open:
		var should_open = _are_all_pressed() if _all_required else _are_any_pressed()
		_set_open(should_open)


func _are_any_pressed() -> bool:
	for plate in _pressure_plates:
		if plate.is_pressed():
			return true
	return false


func _are_all_pressed() -> bool:
	for plate in _pressure_plates:
		if not plate.is_pressed():
			return false
	return true


func _set_open(state: bool) -> void:
	_is_open = state
	_door_mesh.hide() if _is_open else _door_mesh.show()
