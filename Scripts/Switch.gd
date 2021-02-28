extends Node

export(NodePath) var target_path : NodePath = ""
onready var target : Node = get_node_or_null(target_path)

var state : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area_body_entered(body):
	if target == null:
		return
	
	if body is Player and target.get("active") != null:
		target.set("active", true)
		
		state = true
		$OffMesh.visible = false
		$OnMesh.visible = true
