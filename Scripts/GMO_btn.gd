extends Button

@onready var label = $Label
var alphabet: String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
@onready var texture_rect_up = $TextureRectUp
@onready var texture_rect_down = $TextureRectDown
var gray = Color(.47,.47,.47,1)
var point = 1000

# Called when the node enters the scene tree for the first time.
func _ready():
	texture_rect_up.modulate = Color(.47,.47,.47,1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if Input.is_action_just_pressed("ui_down") and has_focus():
		print("letter down")
		change_letter("up")
		texture_rect_down.modulate = Color.WHITE
		await get_tree().create_timer(.2).timeout
		texture_rect_down.modulate = gray
		
		
	elif Input.is_action_just_pressed("ui_up") and has_focus():
		print("letter up")
		change_letter("down")
		texture_rect_up.modulate = Color.WHITE
		await get_tree().create_timer(.2).timeout
		texture_rect_up.modulate = gray

func change_letter(string):
	if string == "up":
		var current_letter = alphabet.find(label.text)
		var next_letter
		if current_letter == 25:
			next_letter = 0
		else:
			next_letter = current_letter + 1
		label.text = alphabet[next_letter]
	elif string == "down":
		var current_letter = alphabet.find(label.text)
		var next_letter
		if current_letter == 0:
			next_letter = 25
		else:
			next_letter = current_letter - 1
		label.text = alphabet[next_letter]
