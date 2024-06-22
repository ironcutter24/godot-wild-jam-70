extends Area3D


@onready var splash_sound = $SplashSound

func _on_body_entered(body):
	if body is PlayerCharacter:
		body.drown()
	
	splash_sound.play()
