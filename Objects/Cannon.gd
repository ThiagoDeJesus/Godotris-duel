extends Node2D

var rot: float = 0
var rot_speed: int = 1
var object_on: bool = false
var construction_preloads: = [preload("res://Objects/constructions/PeçaCurva.tscn"), 
preload("res://Objects/constructions/PeçaL.tscn"), 
preload("res://Objects/constructions/PeçaReta.tscn"),
preload("res://Objects/constructions/PeçaSetas.tscn"),
preload("res://Objects/constructions/Quadradao.tscn")]

func _physics_process(delta: float) -> void:
	cannon_rotation()
	$SpriteCannon.rotate(rot * rot_speed * delta)
	convert_degree()
	if not object_on:
		object_instance()
	
	
func convert_degree () -> void:
	if $SpriteCannon.rotation_degrees > 360:
		$SpriteCannon.rotation_degrees = 0
	if $SpriteCannon.rotation_degrees < 0:
		$SpriteCannon.rotation_degrees = 360

func cannon_rotation() -> float:
	rot = Input.get_action_strength("right1") - Input.get_action_strength("left1")
	return rot
	
func object_instance() -> void:
	object_on = true
	var construction = construction_preloads[1].instance()
	var construction_pos = $SpriteCannon/MuzzleCannon.global_position
	construction.global_position = construction_pos
	$"../".add_child(construction)
