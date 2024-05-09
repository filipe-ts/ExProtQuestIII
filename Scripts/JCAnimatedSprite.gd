extends AnimatedSprite2D

@onready var jacks_car = $".."

var turning_left = false
var turning_right = false
var centering = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if jacks_car.velocity.x == -jacks_car.SPEED:
		turning_left = true
		turn_animation()
	elif jacks_car.velocity.x == jacks_car.SPEED:
		turning_right = true
		turn_animation()
	elif abs(jacks_car.velocity.x) < jacks_car.SPEED and animation != "forword":
		centering = true
		turn_animation()
		
func turn_animation():
	if turning_left and (animation != "left" and animation != "turn_left"):
		play("turn_left")
		turning_left = false
	elif  turning_right and (animation != "right" and animation != "turn_right"):
		play("turn_right")
		turning_right = false
	elif centering:
		if animation == "left" or animation == "turn_left":
			play_backwards("turn_left")
			speed_scale = 3
		elif animation == "right" or animation == "turn_right":
			play_backwards("turn_right")
			speed_scale = 3
			
		

func _on_animation_finished():
	if self.animation == "turn_left":
		play("left")
	if self.animation == "turn_right":
		play("right")
	if centering:
		play("forword")
		speed_scale = 6
		centering = false
