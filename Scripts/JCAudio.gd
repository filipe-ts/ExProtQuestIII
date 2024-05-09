extends AudioStreamPlayer

@onready var jacks_car = $".."


var motor_sound = preload("res://Assets/SONS/Game/mustang_engine_mixdown.wav")
var tires = preload("res://Assets/SONS/Game/tires_mixdown.wav")
# Called when the node enters the scene tree for the first time.
func _ready():
	stream_paused = false
	play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_finished():
	if jacks_car.is_running:
		play()
