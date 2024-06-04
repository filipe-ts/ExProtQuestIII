extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var main_menu = preload("res://Scenes/start_screen.tscn")
	var instance = main_menu.instantiate()
	get_tree().root.add_child.call_deferred(instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
