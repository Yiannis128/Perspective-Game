extends Spatial

export(bool) var focus_pivot_on_player : bool = false

var epiphany_ui_packed : PackedScene = preload("res://UI/EpiphanyUI.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Move children to CameraManager and also
# assign them to the player, if applicable.
func _on_Trigger_body_entered(body):
	if body is Player:
		# Show the UI
		body.add_child(epiphany_ui_packed.instance())
		
		var perspective_point : CameraPerspective = null
		
		for child in get_children():
			if child is CameraPerspective:
				perspective_point = child
				break
		
		assert(perspective_point != null)
		
		if focus_pivot_on_player:
			perspective_point.target_node = body

		CameraPointManager.add_perspective_point(perspective_point)
		
		# Delete the epiphany orb
		queue_free()
