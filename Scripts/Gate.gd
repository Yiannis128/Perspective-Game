extends Node

export(bool) var active = false setget _set_active
export(Resource) var next_level : Resource = null

# Called when the node enters the scene tree for the first time.
func _ready():
	_set_active(active)

func _set_active(value : bool) -> void:
	active = value
	
	if active:
		$AnimationPlayer.play("Open")

func _on_Area_body_entered(body):
	if body is Player:
		# Load next level
		var _val = get_tree().change_scene(next_level.resource_path)
