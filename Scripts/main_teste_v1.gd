extends Node


@onready var cones = $Cones
var cone_scene = preload("res://Scenes/Scenes/cone.tscn")
var cone = cone_scene.instantiate()
@onready var barriers = $Barriers
var barrier_scene = preload("res://Scenes/barrier.tscn")
var barrier = barrier_scene.instantiate()

@onready var cones_timer = $ConesTimer
@onready var barrier_timer = $BarrierTimer
@onready var gerador_de_perguntas = $GeradorDePerguntas
@onready var debug_label = $DebugLabel

var can_spawn_cone = true
var is_barrier_moveble = false
var is_cone_movable = false

var limit_obstcles_velocity_y = 2
@export var obstcles_velocity_y = 1
var max_obstcles_velocity_y = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	barrier_timer.start()
	cones_timer.start()
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
	if is_cone_movable:
		cones.position.y += obstcles_velocity_y


func _on_barrier_timer_timeout():
	var opcoes = gerador_de_perguntas.pergunta_atual["opcoes"]
	var resposta = gerador_de_perguntas.pergunta_atual["resposta_correta"]
	
	barrier = barrier_scene.instantiate()
	barrier.answer = resposta
	barrier.gates_labels = opcoes
	
	
	barriers.add_child(barrier)
	barrier.pergunta.text = gerador_de_perguntas.pergunta_atual["pergunta"]
	barrier.global_position = Vector2(1920/2, -1500)
	
	is_barrier_moveble = true
	
	var min_wait_time = int(12/0.5)
	var max_wait_time = int(20/0.5)
	
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
	

func _on_cones_timer_timeout():
	if can_spawn_cone:
		is_cone_movable = true
		cone = cone_scene.instantiate()
		cones.add_child(cone)
		randomize()
		cone.global_position = Vector2(randi_range(50, 1920-50), -10)
		
	


func _on_barrier_detecter_area_entered(area):
	if area is BarrierArea:
		can_spawn_cone = false
		print("cant_cone")


func _on_barrier_detecter_area_exited(area):
	if area is BarrierArea:
		can_spawn_cone = true
		print("can_cone")
