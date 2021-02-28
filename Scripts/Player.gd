class_name Player
extends KinematicBody

export(float) var max_move_speed = 1000
export(float) var max_turn_rate = 2.2
export(float) var gravity_scale = 9810
export(float) var max_fall_speed = 10000

var velocity : Vector3 = Vector3.ZERO

func _ready() -> void:
	pass
	
func _physics_process(delta) -> void:
	# Calculate move speed on ground.
	var move_dir : float = _get_move_direction()
	
	var forward : Vector3 = _get_forward_vector()
	
	velocity.x = forward.x * max_move_speed * move_dir * delta
	velocity.z = forward.z * max_move_speed * move_dir * delta
	
	# Apply gravity
	# Check if we are touching the floor.
	if is_on_floor():
		velocity.y = 0
	else:
		velocity.y -= gravity_scale * delta * delta
		
		if abs(velocity.y) > max_fall_speed:
			velocity.y = -max_fall_speed * delta
	
	var _val = move_and_slide_with_snap(velocity, Vector3.DOWN, Vector3.UP, \
										false, 4, 0.8028515, true)
	
	# Calculate rotation
	var turn_dir : float = _get_turn_direction()
	rotate_y(turn_dir * max_turn_rate * delta)

func _get_forward_vector() -> Vector3:
	var basis = get_global_transform().basis
	return basis * Vector3.FORWARD

func _get_right_vector() -> Vector3:
	var basis = get_global_transform().basis
	return basis * Vector3.RIGHT

func _get_turn_direction() -> float:
	var turn_acw : float = Input.get_action_strength("turn_acw")
	var turn_cw : float = Input.get_action_strength("turn_cw")
	return turn_acw - turn_cw

func _get_move_direction() -> float:
	var move_forward : float = Input.get_action_strength("move_forward")
	var move_backward : float = Input.get_action_strength("move_backward")
	return move_forward - move_backward
