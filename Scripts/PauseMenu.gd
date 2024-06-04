extends Control

var main_menu = preload("res://Scenes/start_screen.tscn")
@onready var btn_continue = $MarginContainer/VBoxContainer/Button

var focus = false
var can_resume = false
# Called when the node enters the scene tree for the first time.
func _ready():
	btn_continue.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !focus:
		btn_continue.grab_focus()
		focus = true
		
	if get_tree().paused:
		show()
	else:
		hide()


func _on_button_pressed():
	get_tree().call_group("Main", "remove_points_on_pause")
	hide()
	focus = false
	get_tree().paused = false


func _on_sair_pressed():
	var main_menu_instance = main_menu.instantiate()
	get_tree().root.add_child(main_menu_instance)
	get_tree().paused = false
	get_tree().call_group("Main", "_remove_from_tree")
