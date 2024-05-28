extends Control

@onready var score = $Score
var points = 0
var escaped = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if points >= 1000 and !escaped:
		escaped = true
		get_tree().call_group("Main", "_escape")

func change_score(new_points: int):
	points += new_points
	if points < 0:
		points = 0
	score.text = str("%06d" % points)

func _get_points():
	return points
