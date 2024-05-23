extends Area2D

@onready var audio_stream_player_2d = $AudioStreamPlayer2D
var points = -10

signal hit

func _ready():
	pass



func _on_body_entered(body):
	audio_stream_player_2d.play()
	hide() # Player disappears after being hit.
	hit.emit()
	get_tree().call_group("GameHud", "change_score", points)
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionPolygon2D.set_deferred("disabled", true)
	print('colidiu')


func _on_visible_on_screen_notifier_2d_screen_exited():
	await get_tree().create_timer(1).timeout
	queue_free()
