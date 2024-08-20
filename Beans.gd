extends RigidBody3D

var team = "red"  # or "blue"
var speed = 60.0
var attack_range = .25
var attack_force = 20000.0
var foce_multiplier = .1
var targetVector3 = Vector3(0,1.4,0)
var damping = .00005  # Adjust this value to apply damping effect
var max_speed = .5
var start_attacking = 1
@onready var anim_player = $AnimationPlayer


func _ready():
	add_to_group("beans")
	connect("body_entered", Callable(self, "_on_body_entered"))



func _process(delta):
	#print("Current position: ", global_transform.origin)
	#global_transform.origin = global_transform.origin.lerp(targetVector3, .008)
	detect_and_attack_enemies()
	#print("New position: ", global_transform.origin)

func _integrate_forces(state):
	if(start_attacking == 1):
		self.axis_lock_linear_x = true
		self.axis_lock_linear_z = true
		self.axis_lock_angular_x = true
		self.axis_lock_angular_z = true
		Engine.time_scale = 1
	else:
		self.axis_lock_linear_x = false
		self.axis_lock_linear_z = false
		#self.axis_lock_angular_x = false
		#self.axis_lock_angular_z = false
		Engine.time_scale = 0.4
		
		
	var direction = (targetVector3 - global_transform.origin).normalized()
	var distance = global_transform.origin.distance_to(targetVector3)		
			
	if distance > .0001 :
		apply_central_force(direction * .1)  # Apply force towards the target
		#linear_velocity = linear_velocity.limit_length(max_speed)
		linear_velocity *= damping

	
func detect_and_attack_enemies():
	var enemies = get_tree().get_nodes_in_group("beans")
	for enemy in enemies:
		if enemy.team != team and global_transform.origin.distance_to(enemy.global_transform.origin) < attack_range:
			attack(enemy)

func attack(enemy):
	anim_player.play("punch")
	var attack_direction = (enemy.global_transform.origin - global_transform.origin).normalized()
	enemy.apply_central_impulse(attack_direction * attack_force * 80)
	await get_tree().create_timer(1.5).timeout

func set_variable(value):
	start_attacking = value

func _on_body_entered(body:Node):
	print("colliding with", body.name)
	# Check if the collided object is part of a specific group
	if body.is_in_group("target_object_group"):  # Replace with your actual group or condition
		queue_free()  # Remove this bean instance
