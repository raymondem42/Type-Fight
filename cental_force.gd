extends Node3D

var force_strength = 60.0  # Strength of the central force

func _process(delta):
	apply_central_force_to_beans()

func apply_central_force_to_beans():
	var beans = get_tree().get_nodes_in_group("beans")
	for bean in beans:
		if bean is RigidBody3D:
			var direction = (global_transform.origin - bean.global_transform.origin).normalized()
			var force = direction * force_strength
			bean.apply_central_force(force)
