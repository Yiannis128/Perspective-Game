extends Node

# Default camera perspective index.
var _perspectives_node : Node = null
var active_point_index : int = 0 setget _set_active_point_index

func _set_active_point_index(value : int) -> void:
	active_point_index = value
	
	if active_point_index < 0:
		active_point_index = get_points_count() - 1
	elif active_point_index >= get_points_count():
		active_point_index = 0
	
	update_active_camera()
	
func update_active_camera() -> void:
	# Check if pivot index is in range.
	if active_point_index >= 0 and active_point_index < get_points_count():
		# Set pivot on active camera.
		var camera_node : Node = get_viewport().get_camera()
		
		if camera_node is CameraController:
			var camera_controller : CameraController = camera_node
			camera_controller.target = get_camera_point(active_point_index)

func _process(_delta) -> void:
	if Input.is_action_just_pressed("switch_next_camera"):
		_set_active_point_index(active_point_index + 1)
	elif Input.is_action_just_pressed("switch_prev_camera"):
		_set_active_point_index(active_point_index - 1)

func get_points_count() -> int:
	return _perspectives_node.get_child_count()

func get_camera_point(index : int) -> Spatial:
	assert(_perspectives_node != null)
	var camera_point : Spatial = _perspectives_node.get_child(index)
	return camera_point

func add_perspective_point(point : Spatial):
	# Store child's world position, because when it will
	# change parent, it will lose it, then restore it.
	var point_global_t : Transform = point.global_transform
	
	point.get_parent().remove_child(point)
	_perspectives_node.add_child(point)
	
	point.global_transform = point_global_t
