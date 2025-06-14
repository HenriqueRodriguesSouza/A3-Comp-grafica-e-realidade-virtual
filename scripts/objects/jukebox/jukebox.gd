extends StaticBody3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func interact(player) -> void:
	if $"../AudioStreamPlayer3D".is_playing() :
		$"../AudioStreamPlayer3D".stop()
	else:
		$"../AudioStreamPlayer3D".play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
