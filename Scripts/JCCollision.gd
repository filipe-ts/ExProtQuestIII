extends CollisionPolygon2D

@onready var jc_animated_sprite = $"../JCAnimatedSprite"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if jc_animated_sprite.animation == "turn_left":
		var frame = jc_animated_sprite.frame
		match frame:
			0:
				rotation_degrees = 0
				position.x = 0
				scale.y = 1
			1:
				rotation_degrees = -6
				position.x = 0
				scale.y = 1
			2:
				rotation_degrees = -12
				position.x = 0
				scale.y = 1
			3:
				rotation_degrees = -18
				position.x = -1
				scale.y = 1
			4:
				rotation_degrees = -27
				position.x = -3
				scale.y = 1
			5:
				rotation_degrees = -37
				position.x = -3
				scale.y = 1
			6:
				rotation_degrees = -43
				position.x = -4
				scale.y = 1.1
	elif jc_animated_sprite.animation == "turn_right":
		var frame = jc_animated_sprite.frame
		match frame:
			0:
				rotation_degrees = 0
				position.x = 0
				scale.y = 1
			1:
				rotation_degrees = 6
				position.x = 0
				scale.y = 1
			2:
				rotation_degrees = 12
				position.x = 0
				scale.y = 1
			3:
				rotation_degrees = 18
				position.x = 1
				scale.y = 1
			4:
				rotation_degrees = 27
				position.x = 3
				scale.y = 1
			5:
				rotation_degrees = 37
				position.x = 3
				scale.y = 1
			6:
				rotation_degrees = 43
				position.x = 4
				scale.y = 1.1
