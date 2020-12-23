extends RigidBody2D

var arealeftlimit: = 279
var arearightlimit: = 359
var outofplace = true

func _physics_process(delta: float) -> void:
	if linear_velocity <= Vector2(.01,.01) and linear_velocity > Vector2(-.01,-.01) and global_position.x >= arealeftlimit and global_position.x <= arearightlimit and outofplace:
		rotation_degrees = 90
		global_position = global_position.snapped(Vector2(8, 8))
		outofplace = false
		mode = 2
		print(linear_velocity)
	
