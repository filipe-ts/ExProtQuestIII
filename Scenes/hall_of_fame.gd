extends CanvasLayer

var main_menu = preload("res://Scenes/start_screen.tscn")
@onready var back_button = $Back_Button

@onready var _1 = $"MarginContainer/VBoxContainer/#1"
@onready var _2 = $"MarginContainer/VBoxContainer/#2"
@onready var _3 = $"MarginContainer/VBoxContainer/#3"
@onready var _4 = $"MarginContainer/VBoxContainer/#4"
@onready var _5 = $"MarginContainer/VBoxContainer/#5"

var ranking: Array = []

func _ready():
	verify_scoredboard_data()
	
	ranking.append(_1)
	ranking.append(_2)
	ranking.append(_3)
	ranking.append(_4)
	ranking.append(_5)
	
	#var frist = {
			#"name": "FTS",
			#"score":  2000
		#}
	#ProjectSettings.set_setting("_1", frist)
	#var second = {
		#"name": "CLR",
		#"score":  1500
	#}
	#ProjectSettings.set_setting("_2", second)
	#ProjectSettings.save()
	
	for i in range(1,6):
		var rank = ProjectSettings.get_setting("_%d" % i) as Dictionary
		var new_label_text = rank["name"] + ": " + str("%06d" % rank["score"])
		ranking[i-1].text = new_label_text
	
	back_button.grab_focus()

func _on_back_button_pressed():
	
	var main_menu_instance = main_menu.instantiate()
	get_tree().root.add_child(main_menu_instance)
	main_menu_instance.btn_score.grab_focus()
	queue_free()

func verify_scoredboard_data():
	for i in range(1, 6):
		var rank = "_%d" % i
		if ProjectSettings.has_setting(rank):
			print(rank + " already exist")
		else:
			print(rank + " does not exist")
			var empty_rank = {
				"Name": "AAA",
				"Score":  0}
			ProjectSettings.set_setting(rank, empty_rank)
	ProjectSettings.save()

func reset_score_board():
	for i in range(1, 6):
		var rank = "_%d" % i
		print(rank + " recreated")
		var empty_rank = {
			"name": "AAA",
			"score":  0}
		ProjectSettings.set_setting(rank, empty_rank)
	ProjectSettings.save()
