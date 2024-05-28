extends StaticBody2D

class_name BusBurnt

@onready var sprite_2d = $Sprite2D
@onready var collision_shape_2d = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_visible_on_screen_notifier_2d_screen_exited():
	await get_tree().create_timer(1).timeout
	queue_free()


func _on_area_2d_body_entered(body):
	if body is JacksCar:
		var car = body as JacksCar
		car.is_running = false
		car.explosion()
		get_tree().call_group("Main", "stop")
