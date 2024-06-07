extends Node


@onready var cones = $Cones
var cone_scene = preload("res://Scenes/Scenes/cone.tscn")
var cone = cone_scene.instantiate()
@onready var barriers = $Barriers
var barrier_scene = preload("res://Scenes/barrier.tscn")
var barrier = barrier_scene.instantiate()
@onready var road_genator = $RoadGenator
@onready var road_sprite_front = $RoadGenator/RoadSprite
@onready var road_sprite_back = $RoadGenator/RoadSprite2
@onready var audio_stream_player = $AudioStreamPlayer
var gm_overlay = preload("res://Scenes/game_over_overlay.tscn").instantiate()
@onready var game_hud = $GameHud
@onready var wrecks = $Wrecks

@onready var pause_menu = $PauseMenu


@onready var jacks_car = $JacksCar
@onready var cones_timer = $ConesTimer
@onready var barrier_timer = $BarrierTimer
@onready var gerador_de_perguntas = $GeradorDePerguntas
@onready var debug_label = $DebugLabel
@onready var pause_timer = $PauseTimer


var can_spawn_cone = false
var is_barrier_moveble = false
var is_cone_movable = false
var is_road_movable = true
var infinity_mode = false
var begining_game = true
var ending_game = false

var pause_push = 0

var min_obstacle_velocity = 2
var limit_obstcles_velocity_y = 8
@export var obstcles_velocity_y = 2
@export var barrier_velocity_y = 2
var max_obstcles_velocity_y = 2


# Called when the node enters the scene tree for the first time.
func _ready():
	pause_menu.hide()
	barrier_timer.start()
	cones_timer.start()
	gerador_de_perguntas.gerar_pergunta_aleatoria()
	jacks_car.is_running = false
	begin_game()

func begin_game():
	if !infinity_mode:
		var begining_text = preload("res://Scenes/begin_game_text.tscn").instantiate()
		get_tree().root.add_child.call_deferred(begining_text)
		await get_tree().create_timer(3).timeout
		begining_text.queue_free()
	else:
		game_hud.infinity_mode = true
	jacks_car.velocity.y = -100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var debug_label_text = str(obstcles_velocity_y) + "  " + str(max_obstcles_velocity_y) + " " + str(cones_timer.wait_time) + " " + str(pause_push)
	debug_label.text = debug_label_text
	
	if begining_game and jacks_car.position.y <= 864:
		jacks_car.position.y = 864
		jacks_car.velocity.y = 0
		begining_game = false
		jacks_car.is_running = true
		begining_game = false
		audio_stream_player.play()
	
	if ending_game and jacks_car.position.y >= -50:
		jacks_car.velocity.y = -600
	elif ending_game and jacks_car.position.y <= -50:
		ending_game = false
		print(ending_game)
		jacks_car.velocity.y = 0
		game_over(true)
		
		
	if jacks_car.is_running:
		if Input.is_action_pressed("down") and obstcles_velocity_y > min_obstacle_velocity :
			obstcles_velocity_y -= 0.2
		elif Input.is_action_pressed("down") and obstcles_velocity_y <= min_obstacle_velocity:
			obstcles_velocity_y =  min_obstacle_velocity
		elif !Input.is_action_pressed("down") and obstcles_velocity_y < max_obstcles_velocity_y:
			obstcles_velocity_y += 0.5
		elif !Input.is_action_pressed("down") and obstcles_velocity_y >= max_obstcles_velocity_y:
			obstcles_velocity_y = max_obstcles_velocity_y
	
	if is_barrier_moveble:
		barriers.position.y += barrier_velocity_y
		
	if is_cone_movable:
		cones.position.y += obstcles_velocity_y
		wrecks.position.y += obstcles_velocity_y
	
	if is_road_movable:
		road_genator.position.y += obstcles_velocity_y	
		
	if road_sprite_back.global_position.y >= -148:
		road_genator.position.y = 0
	
	if Input.is_action_just_pressed("action"):
		pause_push += 1
		pause_timer.start()
		

	if pause_push > 1:
			pause_push = 0
			if jacks_car.is_running:
				get_tree().paused = true
			
	if Input.is_action_just_pressed("pause"):
		pause_push = 0
		if jacks_car.is_running:
			get_tree().paused = true


func _on_barrier_timer_timeout():
	if jacks_car.is_running:
		var opcoes = gerador_de_perguntas.pergunta_atual["opcoes"]
		var resposta = gerador_de_perguntas.pergunta_atual["resposta_correta"]
		
		barrier = barrier_scene.instantiate()
		barrier.answer = resposta
		barrier.gates_labels = opcoes
		barrier.points = gerador_de_perguntas.pergunta_atual["pontos"]
		
		barriers.add_child(barrier)
		barrier.pergunta.text = gerador_de_perguntas.pergunta_atual["pergunta"]
		barrier.global_position = Vector2(1920/2, -2000)
		
		is_barrier_moveble = true
		
		var min_wait_time = int(12/0.5)
		var max_wait_time = int(20/0.5)
		
		var new_time_duration = randi_range(min_wait_time, max_wait_time)
		barrier_timer.stop()
		gerador_de_perguntas.gerar_pergunta_aleatoria()
		barrier_timer.wait_time = new_time_duration
		
		barrier_timer.start()


func allow_barrier_to_move():
	is_barrier_moveble = true
	


func _on_cones_timer_timeout():
	if can_spawn_cone and jacks_car.is_running:
		is_cone_movable = true
		cone = cone_scene.instantiate()
		cones.add_child(cone)
		randomize()
		#cone.global_position = Vector2(randi_range(50, 1920-50), -10)
		var random_x = round(randfn(jacks_car.position.x, 1920/5))
		while random_x < 254 or random_x > 1686:
			randomize()
			random_x = round(randfn(jacks_car.position.x, 1920/5))
		cone.global_position = Vector2(random_x, -10)



func _on_wrecks_timer_timeout():
	if can_spawn_cone and jacks_car.is_running:
		is_cone_movable = true
		randomize()
		var random_x = round(randfn(jacks_car.position.x, 1920/20))
		while random_x < 254 or random_x > 1686:
			randomize()
			random_x = round(randfn(jacks_car.position.x, 1920/20))
		wrecks.spawn(random_x)


func _on_barrier_detecter_area_entered(area):
	if area is BarrierArea:
		can_spawn_cone = false
		print("cant_cone")


func _on_barrier_detecter_area_exited(area):
	if area is BarrierArea:
		can_spawn_cone = true
		print("can_cone")


func _on_punish_timer_timeout():
	if Input.is_action_pressed("down") and max_obstcles_velocity_y > min_obstacle_velocity:
		get_tree().call_group("GameHud", "change_score", -1)
		
func _increase_obstacle_speed():
	if max_obstcles_velocity_y < limit_obstcles_velocity_y:
		max_obstcles_velocity_y += 0.5
	else:
		max_obstcles_velocity_y = limit_obstcles_velocity_y
		


func stop():
	is_barrier_moveble = false
	is_cone_movable = false
	is_road_movable = false
	game_over(false)

func game_over(end_mode:bool):
	var new_audio_stream
	if end_mode:
		gm_overlay.good_end = true
		new_audio_stream = preload("res://Assets/SONS/music/looperman-l-2409402-0264148-cyberpunk.wav")
	else:
		new_audio_stream = preload("res://Assets/SONS/music/looperman-l-3102386-0304840-cyberpunk-type-bass.wav")
		
	gm_overlay.points = game_hud.points
	await get_tree().create_timer(3).timeout
	game_hud.hide()
	
	get_tree().root.add_child(gm_overlay)
	audio_stream_player.stop()
	audio_stream_player.stream = new_audio_stream
	audio_stream_player.play()

func _on_pause_timer_timeout():
	pause_push = 0
	pause_timer.stop()


func _escape():
	jacks_car.is_running = false
	await get_tree().create_timer(2).timeout
	ending_game = true
	

func remove_points_on_pause():
	if barrier != null:
		barrier.points = 1
		

func _remove_from_tree():
	queue_free()


