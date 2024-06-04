extends Node

func play_music():
	var audio_player = get_node("AudioStreamPlayer")
	if not audio_player.is_playing():
		audio_player.play()


func stop_music():
	var audio_player = get_node("AudioStreamPlayer")
	audio_player.stop()


func pause_music():
	var audio_player = get_node("AudioStreamPlayer")
	audio_player.pause()
