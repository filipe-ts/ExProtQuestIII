extends Sprite2D

class_name Barrier

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
const GATE_POSITION_Y = 56

enum GATE_POSITION{
	A = FRIST_GATE_POSITION_X - POSITION_X_ADJUST,
	B = FRIST_GATE_POSITION_X*3 - POSITION_X_ADJUST,
	C = FRIST_GATE_POSITION_X*5 - POSITION_X_ADJUST,
	D = FRIST_GATE_POSITION_X*7 - POSITION_X_ADJUST,
	E = FRIST_GATE_POSITION_X*9 - POSITION_X_ADJUST
}



@export var correct_gate_index: GATES
var correct_gate = null


@onready var gate_opener = $GateOpener

# Called when the node enters the scene tree for the first time.
func _ready():
	for g in GATES:
		var gate = GATE_SCENE.instantiate()
		var gate_position = GATE_POSITION[g]
		gate.position = Vector2(gate_position, GATE_POSITION_Y)
		add_child(gate)
		if GATES[g] == correct_gate_index:
			correct_gate = gate
			gate.collision_shape_2d.debug_color = Color(0,1,1,0.2)
			gate_opener.position.x = gate.position.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _set_gate(gate: GATES):
	correct_gate = gate


func _on_gate_opener_body_entered(body):
	if body is JacksCar:
		(correct_gate as Gate).set_collision_layer_value(2, false)
