extends RigidBody3D

var team = 1
var target = null

#func _ready():
	#var material = StandardMaterial3D
	#if(team == 1):
		##material.albedo_color = Color.RED
		#print("red team")
	#else:
		##material.albedo_color = Color.BLUE
		#print("blue team")

func _process(delta):
	if target:
		look_at(target.global_transform.origin, Vector3.UP)
		apply_impulse(Vector3.ZERO, transform.basis.z * 10)
		
