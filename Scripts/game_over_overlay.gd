extends Control

@onready var button_1 = $PanelContainer/Button
@onready var salvar = $VBoxContainer2/Salvar
@onready var score_label = $ScoreLabel
var bad_game_over_string = "FIM DE JOGO"
var good_game_over_string = "SUCESSO"
@onready var game_over = $GameOver

var good_end = false

var points = 123456

# Called when the node enters the scene tree for the first time.
func _ready():
	button_1.grab_focus()
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
	get_tree().change_scene_to_file("res://Scenes/start_screen.tscn")


func _on_salvar_pressed():
	#TODO Update scoreboard
	get_tree().change_scene_to_file("res://Scenes/start_screen.tscn")
