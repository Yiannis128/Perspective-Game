extends Label

export(float) var fill_speed : float = 0.01

func _ready():
	percent_visible = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	percent_visible += delta * fill_speed
