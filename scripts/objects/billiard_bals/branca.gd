extends RigidBody3D

# Velocidade constante desejada (ajuste o valor conforme necessário)
const SPEED = 6.0
var ball_initial_position = self.global_transform

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func interact(player) -> void:
	if not ball_initial_position:
		ball_initial_position = self.global_transform
	# Acessa a câmera do jogador
	var camera = player.get_node("head/Camera3D")

	var forward = -camera.global_transform.basis.z
	forward.y = 0 # Ignora altura (Y)
	forward = forward.normalized()
	linear_velocity = forward * SPEED

func reset() -> void:
	print("resetou", ball_initial_position)
	self.global_transform = ball_initial_position
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
