extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const SENSITIVITY = 0.02
var movement_disabled: bool = false

@onready var head = $head
@onready var camera = $head/Camera3D

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(80))
		
func disable_movement(duration: float) -> void:
	movement_disabled = true
	await get_tree().create_timer(duration).timeout
	movement_disabled = false
	
func disable_collision(duration: float) -> void:
	$CollisionShape3D.disabled = true
	await get_tree().create_timer(duration).timeout
	$CollisionShape3D.disabled = false

func dont_show_interact() -> void:
	$CanvasLayer/BoxContainer/InteractText.hide() 	
	
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	$CanvasLayer/BoxContainer/InteractText.hide()	
	$CanvasLayer/BoxContainer/InteractTextReset.hide()	
	if %SeeCast.is_colliding():
		var target = %SeeCast.get_collider()
		if target != null and target.has_method("interact"):
			$CanvasLayer/BoxContainer/InteractText.show()
			if Input.is_action_just_pressed("action"):
				target.interact(self)
		if target.has_method("reset"):
			$CanvasLayer/BoxContainer/InteractText.hide()	
			$CanvasLayer/BoxContainer/InteractTextReset.show()
			if Input.is_action_just_pressed("reset"):
				target.reset()
				
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Se o movimento estiver desabilitado, ignora a entrada do usuário
	if movement_disabled:
		# Mantém a gravidade, mas zera o movimento horizontal:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		move_and_slide()
		return

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("character_left", "character_right", "character_up", "character_down")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
