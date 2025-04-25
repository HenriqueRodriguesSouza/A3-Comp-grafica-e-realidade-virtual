extends StaticBody3D

var initial_position: Vector3
var initial_rotation: Vector3
@export var return_delay: float = 2.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func interact(player) -> void:
	initial_position = Vector3(-1.173, 1.114, -0.396)
	initial_rotation = Vector3(0, 0 , 0)
	$"../..".drink(initial_position , initial_rotation, player)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
