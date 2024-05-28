extends Control

var can_resume = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !can_resume:
		await get_tree().create_timer(.1).timeout
		can_resume = true
		
	if Input.is_action_just_pressed("action") and can_resume:
		can_resume = false
		get_tree().call_group("Main", "remove_points_on_pause")
		get_tree().paused = false
