extends CanvasLayer

var main_menu = preload("res://Scenes/start_screen.tscn")
@onready var back_button = $Back_Button

func _ready():
	back_button.grab_focus()
	var audio_player = Globalmusic.get_node("AudioStreamPlayer")
	if not audio_player.is_playing():
		audio_player.play()


func _on_back_button_pressed():
	var main_menu_instance = main_menu.instantiate()
	get_tree().root.add_child(main_menu_instance)
	main_menu_instance.btn_manual.grab_focus()
	queue_free()
