extends Control

@onready var btn_1 = $PanelContainer/Button
@onready var btn_2 = $PanelContainer/Btn2
@onready var btn_3 = $PanelContainer/Button3

@onready var salvar = $VBoxContainer2/Salvar
@onready var score_label = $ScoreLabel
var bad_game_over_string = "FIM DE JOGO"
var good_game_over_string = "SUCESSO"
@onready var game_over = $GameOver

var main_menu = preload("res://Scenes/start_screen.tscn")

var good_end = false

var points = 123456

# Called when the node enters the scene tree for the first time.
func _ready():
	btn_1.grab_focus()
	score_label.text = "Pontuação: " + str("%06d" % points)
	if good_end:
		game_over.text = good_game_over_string
	else:
		game_over.text = bad_game_over_string
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	salvar.grab_focus()


func _on_sem_salvar_pressed():
	var main_menu_instance = main_menu.instantiate()
	get_tree().root.add_child(main_menu_instance)
	get_tree().call_group("Main", "_remove_from_tree")
	#queue_free()


func _on_salvar_pressed():
	#TODO Update scoreboard
	load_hall_of_fame()
	var main_menu_instance = main_menu.instantiate()
	get_tree().root.add_child(main_menu_instance)
	get_tree().call_group("Main", "_remove_from_tree")

func load_hall_of_fame():
	var hall_of_fame: Array = []
	var buffer: Array = []
	for i in range(1, 6):
		var rank = ProjectSettings.get_setting("_%d" % i)
		hall_of_fame.append(rank)
		buffer.append(rank)
	print(hall_of_fame)
	
	var player_name = btn_1.label.text + btn_2.label.text + btn_3.label.text
	print("PlayerName: " + str(player_name))
	
	for i in range(5):
		if points >  hall_of_fame[i]["score"]:
			print(str(points) + " > " + str(hall_of_fame[i]["score"]))
			for j in range(i+1, 5):
				hall_of_fame[j] = buffer[j-1]
			hall_of_fame[i] = {"name": player_name, "score": points}
			break
		else:
			print(str(points) + " < " + str(hall_of_fame[i]["score"]))
	
	for i in range(1, 6):
		ProjectSettings.set_setting("_%d" % i, hall_of_fame[i-1])
	ProjectSettings.save()
