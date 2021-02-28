class_name CameraController
extends Camera

export(NodePath) onready var target_path : NodePath = "" setget _set_target_path
var target : Spatial setget _set_target

export(float) var lerp_speed : float = 3.0

func _process(delta) -> void:
	if target != null:
		translation = lerp(translation, target.translation, delta * lerp_speed)
		
		# Need to lerp using quaternions because euler angles break here.
		var rot : Quat = Quat(rotation)
		var target_rot : Quat = Quat(target.rotation)
		rot = rot.slerp(target_rot, delta * lerp_speed)
		rotation = rot.get_euler()

func _set_target_path(value : NodePath) -> void:
	target_path = value
	_set_target(get_node_or_null(target_path))
	
func _set_target(value : Spatial) -> void:
	target = value
