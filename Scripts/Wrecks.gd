extends Node2D

var wreck_1 = preload("res://Scenes/ambulance_wreck.tscn")
var wreck_2 = preload("res://Scenes/police_wreck.tscn")
var wreck_3 = preload("res://Scenes/bus_burnt.tscn")

var wrecks_vec = [wreck_1, wreck_2, wreck_3]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn(position_x: float):
	randomize()
	var new_wreck = wrecks_vec[randi() % wrecks_vec.size()]
	new_wreck = new_wreck.instantiate()
	add_child(new_wreck)
	new_wreck.global_position = Vector2(position_x, -10)
