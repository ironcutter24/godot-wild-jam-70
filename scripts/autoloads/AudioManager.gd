class_name AudioManager
extends Node


var _stream_index : int = 0
@export var _stream_players : Array[AudioStreamPlayer]

@export_group("Sounds")
@export var _beep_sound : AudioStream
func play_beep(): _play_sound(_beep_sound, -28.0)
@export var _arrow_hit_sound : AudioStream
func play_arrow_hit(): _play_sound(_arrow_hit_sound, -8.0)


func _play_sound(sound: AudioStream, volume: float = 0.0):
	_stream_index = _clampi_circular(_stream_index + 1, 0, _stream_players.size())
	var stream_player = _stream_players[_stream_index]
	stream_player.stream = sound
	stream_player.volume_db = volume
	stream_player.play()


func _clampi_circular(val: int, min_inclusive: int, max_exclusive: int) -> int:
	var ran = max_exclusive - min_inclusive  # Range
	return ((val - min_inclusive) % ran + ran) % ran + min_inclusive
