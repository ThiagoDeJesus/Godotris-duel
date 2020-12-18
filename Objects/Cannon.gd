extends Node2D

var construction_preloads: = [preload("res://Objects/constructions/PeçaCurva.tscn"), 
preload("res://Objects/constructions/PecaL.tscn"), 
preload("res://Objects/constructions/PeçaReta.tscn"),
preload("res://Objects/constructions/PeçaSetas.tscn"),
preload("res://Objects/constructions/Quadradao.tscn")]

var shot_vel: int = 300
var previewrot: float = 0
var rot: float = 0
var rot_speed: int = 1
var object_on: bool = false

var construction_pos: Vector2
var nodename: String
var previewnodename: String
var forma: int
var forca: float

func _ready() -> void:
	randomize()

func _physics_process(delta: float) -> void:
	cannon_rotation()
	$SpriteCannon.rotate(rot * rot_speed * delta)
	convert_degree()
	if not object_on:
		object_preview()
	if object_on:
		preview_rotation()
		get_parent().get_node(previewnodename).rotate(previewrot * 2 * delta)
	if Input.is_action_pressed("shot1"):
		forca = lerp(forca, 1.0, .008)
		$Container.text = str(int(forca * 100))
	if Input.is_action_just_released("shot1") and forca > 0:
		object_instance()
		get_parent().get_node(previewnodename).queue_free()
		forca = 0
		object_on = false
	
func convert_degree () -> void:
	if $SpriteCannon.rotation_degrees > 75:
		$SpriteCannon.rotation_degrees = 75
	if $SpriteCannon.rotation_degrees < -75:
		$SpriteCannon.rotation_degrees = -75

func cannon_rotation() -> float:
	rot = Input.get_action_strength("right1") - Input.get_action_strength("left1")
	return rot

func preview_rotation() -> float:
	previewrot = Input.get_action_strength("right_preview_rotation1") - Input.get_action_strength("left_preview_rotation1")
	return previewrot
	
func object_preview() -> void:
	object_on = true
	forma = randi()%construction_preloads.size()
	var previewconstruction = construction_preloads[forma].instance()
	var previewconstruction_pos: Vector2 = get_parent().get_node("Level/Player1Preview").global_position
	previewconstruction.mode = 3
	previewconstruction.collision_layer = 0
	previewconstruction.collision_mask = 0
	previewconstruction.global_position = previewconstruction_pos
	previewconstruction.name = str(previewconstruction)
	previewnodename = previewconstruction.name
	get_parent().add_child(previewconstruction)
	
func object_instance() -> void:
	var construction = construction_preloads[forma].instance()
	construction_pos = $SpriteCannon/MuzzleCannon.global_position
	construction.global_position = construction_pos
	construction.global_rotation = get_parent().get_node(previewnodename).global_rotation
	construction.name = str(construction)
	nodename = construction.name
	get_parent().add_child(construction)
	var direction = get_parent().get_node(nodename).global_position.direction_to($SpriteCannon/ShootDirection.global_position).normalized()
	get_parent().get_node(nodename).apply_central_impulse(direction * shot_vel * forca)

