extends Node2D

var rot: float = 0
var rot_speed: int = 1
var object_on: bool = false
var construction_preloads: = [preload("res://Objects/constructions/PeçaCurva.tscn"), 
preload("res://Objects/constructions/PecaL.tscn"), 
preload("res://Objects/constructions/PeçaReta.tscn"),
preload("res://Objects/constructions/PeçaSetas.tscn"),
preload("res://Objects/constructions/Quadradao.tscn")]
var construction
var construction_pos: Vector2
var nodename: String

func _physics_process(delta: float) -> void:
	cannon_rotation()
	$SpriteCannon.rotate(rot * rot_speed * delta)
	convert_degree()
	if not object_on:
		object_instance()
	if object_on:
		pre_shoot()
	
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
	construction = construction_preloads[1].instance()
	construction_pos = $SpriteCannon/MuzzleCannon.position
	construction.position = construction_pos
	construction.mode = 3
	nodename = construction.name
	self.add_child(construction)

func pre_shoot() ->void:
	construction_pos = $SpriteCannon/MuzzleCannon.global_position
	get_node(nodename).global_position = construction_pos
