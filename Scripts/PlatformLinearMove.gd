extends Spatial

export(bool) var active : bool = true
export(Vector3) var max_offset : Vector3 = Vector3.ZERO
export(float) var speed : float = 1.5
export(float) var phase_mult : float = 0

onready var initial_position : Vector3 = translation


var phase : float = 0

func _ready():
	translation = initial_position + \
				  sin(phase * speed + phase_mult * PI) * max_offset

func _physics_process(delta : float) -> void:
	if active and Input.is_action_pressed("move_time"):
		phase += delta
		translation = initial_position + \
						sin(phase * speed + phase_mult * PI) * max_offset
