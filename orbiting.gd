extends Node3D

var orbit_speed = .06
@onready var camera = $Camera3D
var target_position = Vector3(2.364, .9, -.298)
var speed: float = .50
var cameraRound = 0


func _process(delta):
	# Rotate the parent node around the Y-axis
	if(cameraRound == 0):
		rotate_y(0)
	elif(cameraRound ==1):
		#camera.global_transform.origin = target_position
		#print(camera.global_transform.origin)
		rotate_y(orbit_speed * delta)
		#camera.global_transform.origin = camera.global_transform.origin.lerp(target_position, speed * delta)
		#camera.global_transform.origin = target_position
		#cameraRound = 0  # Stop moving

func _MoveCameraIn():
	cameraRound = 1
