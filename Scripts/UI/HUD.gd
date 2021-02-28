extends Control

func _process(_delta : float) -> void:
	var point_index : int = CameraPointManager.active_point_index + 1
	var max_points : int = CameraPointManager.get_points_count()
	$Label.text = "Perspective: " + str(point_index) + "/" + str(max_points)
