extends Node2D

var rot: float = 0
var rot_speed: int = 1

func _physics_process(delta: float) -> void:
	cannon_rotation()
	$SpriteCannon.rotate(rot * rot_speed * delta)
	convert_degree()

func convert_degree () -> void:
	if $SpriteCannon.rotation_degrees > 360:
		$SpriteCannon.rotation_degrees = 0
	if $SpriteCannon.rotation_degrees < 0:
		$SpriteCannon.rotation_degrees = 360

func cannon_rotation() -> float:
	rot = Input.get_action_strength("right1") - Input.get_action_strength("left1")
	return rot
	
