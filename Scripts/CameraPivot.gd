class_name CameraPerspective
extends Spatial

export(NodePath) var target_node_path : NodePath = ""

var target_node : Spatial = null setget _set_target_node
var target_node_offset : Vector3 = Vector3.ZERO

func _set_target_node(value : Spatial) -> void:
	target_node = value
	
	if target_node != null:
		target_node_offset = global_transform.origin - target_node.global_transform.origin

func _ready() -> void:
	_set_target_node(get_node_or_null(target_node_path))
	
	if !Engine.editor_hint:
		$Geometry.hide()

func _process(_delta) -> void:
	if target_node != null:
		transform.origin = target_node.global_transform.origin + target_node_offset
