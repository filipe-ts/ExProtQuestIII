extends Sprite2D

class_name Barrier

@onready var visible_on_screen_notifier_2d = $VisibleOnScreenNotifier2D

const GATE_SCENE = preload("res://Scenes/gate.tscn")

enum GATES {
	A,
	B,
	C,
	D,
	E
}

const FRIST_GATE_POSITION_X = 96
const POSITION_X_ADJUST = 96*5
const GATE_POSITION_Y = 56 + 36

enum GATE_POSITION{
	A = FRIST_GATE_POSITION_X - POSITION_X_ADJUST,
	B = FRIST_GATE_POSITION_X*3 - POSITION_X_ADJUST,
	C = FRIST_GATE_POSITION_X*5 - POSITION_X_ADJUST,
	D = FRIST_GATE_POSITION_X*7 - POSITION_X_ADJUST,
	E = FRIST_GATE_POSITION_X*9 - POSITION_X_ADJUST
}



@export var correct_gate_index: GATES
var correct_gate = null
var answer = null
var points = 100


@onready var gate_opener = $GateOpener
@onready var gate_holder = $GateHolder

@onready var pergunta = $Pergunta



@onready var gate_a = $GateA
@onready var gate_b = $GateB
@onready var gate_c = $GateC
@onready var gate_d = $GateD
@onready var gate_e = $GateE
var gate_array = [gate_a, gate_b, gate_c, gate_d, gate_e]
var gates_labels: Array

# Called when the node enters the scene tree for the first time.
func _ready():
	set_gates_labels(gates_labels)
	for g in GATES:
		var gate = GATE_SCENE.instantiate()
		var gate_position = GATE_POSITION[g]
		gate.position = Vector2(gate_position, GATE_POSITION_Y)
		gate_holder.add_child(gate)
		if GATES[g] == correct_gate_index:
			correct_gate = gate
			gate_opener.position.x = gate.position.x
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _set_gate(gate: GATES):
	correct_gate = gate


func _on_gate_opener_body_entered(body):
	if body is JacksCar:
		(correct_gate as Gate).set_collision_layer_value(2, false)
		correct_gate.collision_shape_2d.debug_color = Color(0,1,1,0.2)
		(correct_gate as Gate).animated_sprite_2d.play("open", 1.4)
		await get_tree().create_timer(1).timeout
		get_tree().call_group("GameHud", "change_score", points)
		get_tree().call_group("Main", "_increase_obstacle_speed")
		get_tree().call_group("ConesTimer", "_decresed_timer")


func _on_visible_on_screen_notifier_2d_screen_exited():
	await get_tree().create_timer(3).timeout
	queue_free()

func set_gates_labels(opcoes: Array):
	gate_array = [gate_a, gate_b, gate_c, gate_d, gate_e]
	opcoes.shuffle()
	for i in range(5):
		(gate_array[i] as Label).text = str(opcoes[i])
		if opcoes[i] == answer:
			correct_gate_index = i
