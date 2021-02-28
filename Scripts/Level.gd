extends Node

export(NodePath) var perspectives_node_path : NodePath = ""
export(NodePath) var player_path : NodePath = ""
export(float) var player_respawn_height : float = -20

var player : Player = null

var _respawn_transform : Transform = Transform.IDENTITY

func _ready() -> void:
	CameraPointManager._perspectives_node = get_node(perspectives_node_path)
	CameraPointManager.update_active_camera()
	
	player = get_node(player_path)
	_respawn_transform = player.global_transform

func _process(_delta : float) -> void:
	if player.global_transform.origin.y < player_respawn_height:
		player.global_transform = _respawn_transform
