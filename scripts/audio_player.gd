extends Node


var hurt = preload("res://assets/audio/hurt.wav")
var jump = preload("res://assets/audio/jump.wav")


func play_sfx(sfx_name: String):
	var stream = null
	match sfx_name:
		"hurt":
			stream = hurt
		"jump":
			stream = jump
		_:
			print("Invalid sfx name")
			return
	
	var asp = AudioStreamPlayer.new()
	asp.stream = stream
	asp.name = "SFX"
	add_child(asp)
	
	asp.play()
	
	await asp.finished
	asp.queue_free()