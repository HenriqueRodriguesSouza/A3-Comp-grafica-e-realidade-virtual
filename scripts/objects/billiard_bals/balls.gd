extends RigidBody3D

func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	var contact_count = state.get_contact_count()

	for i in range(contact_count):
		var collider = state.get_contact_collider_object(i)
		if collider is RigidBody3D:
			print("Colidiu com: ", collider.name)
