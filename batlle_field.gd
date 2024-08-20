extends Node3D

@onready var area = $Area3D
var top_erase = 0 
# Called when the node enters the scene tree for the first time.
func _ready():
	# Assuming 'area' is the name of your Area3D node
	area.connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	var node_with_Tracking = get_node("CanvasLayer/Control")
	if(top_erase == 1):
		if body is RigidBody3D:
			var parent = body.get_parent()
			if parent:
				if(parent.team == "red"):
					node_with_Tracking.TrackBeanCount(2)
				else:
					node_with_Tracking.TrackBeanCount(1)
				parent.queue_free()
			
				
		#body.queue_free()  # This will remove the colliding body
	
func enable_top():
	top_erase = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
