extends StaticBody2D

class_name Gate

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var collision_shape_2d = $CollisionShape2D as CollisionShape2D
@onready var area_2d = $Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_body_entered(body):
	if body is JacksCar:
		animated_sprite_2d.play("wrong", 1)
		var car = body as JacksCar
		car.is_running = false
		car.explosion()
		get_tree().call_group("Main", "stop")
