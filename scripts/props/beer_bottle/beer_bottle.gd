extends Node3D

var target_position: Vector3
@export var return_delay: float = 2.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func drink(initial_position: Vector3, initial_rotation: Vector3, player):
	$Cylinder/beer/CollisionShape3D.disabled = true
	
	var duration: float = 3.0
	var elapsed_time: float = 0.0
	var update_interval: float = 0.1
	
	# Obtém a referência da câmera do player
	var camera_node = player.get_node("head/Camera3D")
	
	# Define um offset local (em metros) para posicionar a garrafa em frente à câmera.
	# Em Godot, a direção para frente da câmera é -Z.
	var local_offset: Vector3 = Vector3(0, 0, -0.35)
	
	# Cria uma Basis com o offset de rotação desejado no eixo Z (-127 graus)
	var rotation_offset: Basis = Basis().rotated(Vector3(1, 0, 0), deg_to_rad(110))
	$AudioStreamPlayer3D_Open.play()
	while elapsed_time < duration:
		# Multiplica a Basis da câmera pelo vetor de offset para converter do espaço local para global
		var global_offset: Vector3 = camera_node.global_transform.basis * local_offset
		# Posiciona a garrafa na posição da câmera + o offset transformado
		global_position = camera_node.global_transform.origin + global_offset
		# Alinha a garrafa com a orientação da câmera e aplica o offset de rotação
		global_transform.basis = camera_node.global_transform.basis * rotation_offset
		
		await get_tree().create_timer(update_interval).timeout
		elapsed_time += update_interval
	$AudioStreamPlayer3D_End.play()
	# Após o tempo, retorna a garrafa para a posição e rotação iniciais
	global_position = initial_position
	global_rotation_degrees = initial_rotation
	$Cylinder/beer/CollisionShape3D.disabled = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
