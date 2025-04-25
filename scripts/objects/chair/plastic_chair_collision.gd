extends StaticBody3D

#Posição final na cadeira
@export var sit_offset_x: float = 0.0
@export var sit_offset_y: float = -1.0
@export var sit_offset_z: float = 0.0  # sentar 1 unidade atrás da cadeira

var is_sitting: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func interact(player) -> void:	
	var duration: float = 4.0
	var elapsed_time: float = 0.0
	var update_interval: float = 0.1
	
	var player_initial_position = player.global_transform

	if not is_sitting:
		is_sitting=true
		#$CollisionShape3D.disabled = true
		# Cria o transform de destino
		var new_transform = Transform3D()
		new_transform.basis = self.global_transform.basis

		# Cria um vetor de offset local e converte para espaço global
		var local_offset = Vector3(sit_offset_x, sit_offset_y, sit_offset_z)
		var global_offset = self.global_transform.basis * local_offset

		# Define a posição final
		new_transform.origin = self.global_transform.origin + global_offset

		# Aplica a nova transform no player
		player.set_global_position(new_transform.origin)
		player.set_global_rotation(new_transform.basis.get_euler()) 
		while elapsed_time < duration: 
			
			player.dont_show_interact()
			player.disable_collision(duration)
			player.disable_movement(duration)
			player.set_physics_process(false)
			
			await get_tree().create_timer(update_interval).timeout
			elapsed_time += update_interval
			
		player.global_transform = player_initial_position
		is_sitting=false
		$CollisionShape3D.disabled = false
		player.set_physics_process(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
