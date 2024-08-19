extends RigidBody3D

var team = "red"  # or "blue"
var speed = 60.0
var attack_range = 2.0
var attack_force = 2000.0
var foce_multiplier = .1
var targetVector3 = Vector3(0,1.4,0)
var damping = .00005  # Adjust this value to apply damping effect
var max_speed = .0005
var on_ground = true


func _ready():
	add_to_group("beans")
	contact_monitor = true
	max_contacts_reported = 5
	Engine.time_scale = 0.4
			
#
#func _process(delta):
	#print("Current position: ", global_transform.origin)
	#global_transform.origin = global_transform.origin.lerp(targetVector3, .008)
	#detect_and_attack_enemies()
	#print("New position: ", global_transform.origin)

func _integrate_forces(state):
	var direction = (targetVector3 - global_transform.origin).normalized()
	var distance = global_transform.origin.distance_to(targetVector3)
	for i in range(state.get_contact_count()):
		var contact_normal = state.get_contact_local_normal(i)
		if contact_normal.dot(Vector3.UP) > 0.9:
			on_ground = true
			print("working")
			break
		else:
			on_ground = false
			
			
	if distance > .000000000000000000001 and on_ground:
		apply_central_force(direction * .000000000010000000000100000000001 * .000000000010000000000100000000001)  # Apply force towards the target
		linear_velocity = linear_velocity.limit_length(max_speed)
		linear_velocity *= damping

	
func detect_and_attack_enemies():
	var enemies = get_tree().get_nodes_in_group("beans")
	for enemy in enemies:
		if enemy.team != team and global_transform.origin.distance_to(enemy.global_transform.origin) < attack_range:
			attack(enemy)

func attack(enemy):
	var attack_direction = (enemy.global_transform.origin - global_transform.origin).normalized()
	enemy.apply_central_impulse(attack_direction * attack_force)

func apply_knockback(direction):
	var knockback_force = 30.0
	apply_central_impulse(direction * knockback_force)
