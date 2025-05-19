extends StaticBody3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func interact(player) -> void:
#	Desligar a luz e aparecer os difusores para tampar a luz
	var parent = get_parent().get_parent()
	parent.luz1.visible = not parent.luz1.visible
	parent.luz2.visible = not parent.luz2.visible
	var difusor1 = parent.bar_base.get_node("luz_1/Diffuser")
	var difusor2 = parent.bar_base.get_node("luz_2/Diffuser_002")
	difusor1.visible = not difusor1.visible
	difusor2.visible = not difusor2.visible
	
#	Fazer o botão girar
	parent.rotation_degrees.x += 180
#	Dar o play no click sound
	$"../AudioStreamPlayer3D".play()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
