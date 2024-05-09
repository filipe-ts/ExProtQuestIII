extends AudioStreamPlayer

@onready var jacks_car = $".."
var can_play = true
@onready var jc_animated_sprite = $"../JCAnimatedSprite"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#if jc_animated_sprite.animation == "left" and can_play:
		#play()
		#can_play = false
	#elif jc_animated_sprite.animation == "right" and can_play:
		#play()
		#can_play = false
	#elif jc_animated_sprite.animation != "left" and jc_animated_sprite.animation != "right":
		#can_play = true
