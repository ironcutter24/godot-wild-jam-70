extends Control


const SPLASH_DURATION = 3.6


func _ready():
	await get_tree().create_timer(SPLASH_DURATION).timeout
	Global.load_game_scene()
