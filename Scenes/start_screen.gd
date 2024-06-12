extends CanvasLayer

@onready var btn_fuga = $MarginContainer/VBoxContainer/Button
@onready var btn_score = $MarginContainer/VBoxContainer/Button2
@onready var btn_manual = $MarginContainer/VBoxContainer/Button4

func _ready():
	var audio_player = Globalmusic.get_node("AudioStreamPlayer")
	if not audio_player.is_playing():
		audio_player.play()
	btn_fuga.grab_focus()

func _on_button_pressed():
	var main_ = preload("res://Scenes/main.tscn")
	var main_scene = main_.instantiate()
	
	main_scene.infinity_mode = false
	hide()
	get_tree().root.add_child(main_scene)
	
	var audio_player = Globalmusic.get_node("AudioStreamPlayer")
	audio_player.stop()
	print("limpar")
	queue_free()


func _on_btn_modo_infinito_pressed():
	var main_ = preload("res://Scenes/main.tscn")
	var main_scene = main_.instantiate()
	
	main_scene.infinity_mode = true
	hide()
	get_tree().root.add_child(main_scene)
	
	var audio_player = Globalmusic.get_node("AudioStreamPlayer")
	audio_player.stop()
	print("limpar")
	queue_free()
	


func _on_button_2_pressed():
	var score_board_scene = preload("res://Scenes/score_board.tscn")
	var instance = score_board_scene.instantiate()
	get_tree().root.add_child(instance)
	queue_free()

func _on_button_3_pressed():
	pass

func _on_button_4_pressed():
	var config_scene = preload("res://Scenes/config.tscn")
	var instance = config_scene.instantiate()
	get_tree().root.add_child(instance)
	queue_free()

func _on_btn_sair_pressed():
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit(0)
	
