extends CanvasLayer


func _ready():
	pass


func _process(delta):
	pass
	

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")



func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://Scenes/score_board.tscn")
	


func _on_button_3_pressed():
	pass
