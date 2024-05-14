extends Node

@onready var barriers = $Barriers
var barrier_scene = preload("res://Scenes/barrier.tscn")
var barrier = barrier_scene.instantiate()
@onready var barrier_timer = $BarrierTimer

var is_barrier_moveble = false

@export var obstcles_velocity_y = 2


# Called when the node enters the scene tree for the first time.
func _ready():
	barrier_timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_barrier_moveble:
		barriers.position.y += obstcles_velocity_y


func _on_barrier_timer_timeout():
	var opcoes = range(10,15)
	var resposta = 13
	
	barrier = barrier_scene.instantiate()
	barrier.answer = resposta
	barrier.gates_labels = opcoes
	
	barriers.add_child(barrier)
	barrier.global_position = Vector2(1920/2, -200)
	
	is_barrier_moveble = true
	
	var new_time_duration = randi_range(3,10)
	barrier_timer.stop()
	barrier_timer.wait_time = new_time_duration
	barrier_timer.start()

func allow_barrier_to_move():
	is_barrier_moveble = true
	
