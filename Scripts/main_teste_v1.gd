extends Node

@onready var barriers = $Barriers
var barrier_scene = preload("res://Scenes/barrier.tscn")
var barrier = barrier_scene.instantiate()
@onready var barrier_timer = $BarrierTimer
@onready var gerador_de_perguntas = $GeradorDePerguntas
@onready var debug_label = $DebugLabel

var is_barrier_moveble = false

var limit_obstcles_velocity_y = 1.5
@export var obstcles_velocity_y = 0.5
var max_obstcles_velocity_y = 0.5


# Called when the node enters the scene tree for the first time.
func _ready():
	barrier_timer.start()
	gerador_de_perguntas.gerar_pergunta_aleatoria()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var debug_label_text = str(obstcles_velocity_y) + "  " + str(max_obstcles_velocity_y)
	debug_label.text = debug_label_text
	
	if Input.is_action_pressed("down") and obstcles_velocity_y > 0.5:
		obstcles_velocity_y -= 0.002
	elif Input.is_action_pressed("down") and obstcles_velocity_y <= 0.5:
		obstcles_velocity_y = 0.5
	elif !Input.is_action_pressed("down") and obstcles_velocity_y < max_obstcles_velocity_y:
		obstcles_velocity_y += 0.02
	elif !Input.is_action_pressed("down") and obstcles_velocity_y >= max_obstcles_velocity_y:
		obstcles_velocity_y = max_obstcles_velocity_y
	
	if is_barrier_moveble:
		barriers.position.y += obstcles_velocity_y
	


func _on_barrier_timer_timeout():
	var opcoes = gerador_de_perguntas.pergunta_atual["opcoes"]
	var resposta = gerador_de_perguntas.pergunta_atual["resposta_correta"]
	
	barrier = barrier_scene.instantiate()
	barrier.answer = resposta
	barrier.gates_labels = opcoes
	
	
	barriers.add_child(barrier)
	barrier.pergunta.text = gerador_de_perguntas.pergunta_atual["pergunta"]
	barrier.global_position = Vector2(1920/2, -200)
	
	is_barrier_moveble = true
	
	var min_wait_time = int(8/0.5)
	var max_wait_time = int(12/0.5)
	
	var new_time_duration = randi_range(min_wait_time, max_wait_time)
	barrier_timer.stop()
	gerador_de_perguntas.gerar_pergunta_aleatoria()
	barrier_timer.wait_time = new_time_duration
	
	if max_obstcles_velocity_y < limit_obstcles_velocity_y:
		max_obstcles_velocity_y += 0.02
	else:
		max_obstcles_velocity_y = limit_obstcles_velocity_y
		
	barrier_timer.start()

func allow_barrier_to_move():
	is_barrier_moveble = true
	
