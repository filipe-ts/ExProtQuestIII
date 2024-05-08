extends CharacterBody2D

class_name JacksCar


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const FRICTION_SPEED = 20

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION_SPEED)

	move_and_slide()
