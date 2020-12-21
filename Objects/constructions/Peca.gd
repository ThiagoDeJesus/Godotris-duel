extends RigidBody2D

var rot: float
var naarea: bool = false
var rodado: bool = false

func _physics_process(delta: float) -> void:
	if self.mode != 0:
		set_physics_process(false)
	convert_degree()
	if linear_velocity == Vector2.ZERO and global_rotation_degrees != rot and not rodado and naarea:
		land_degree()
		rodado = true
		
func convert_degree() -> void:
	if global_rotation_degrees > 360:
		global_rotation_degrees = 0
	if global_rotation_degrees < 0:
		global_rotation_degrees = 360
		
func land_degree() ->void:
	var dif: = []
	var teste: float
	dif.append(int(abs(global_rotation_degrees - 90)))
	dif.append(int(abs(global_rotation_degrees - 180)))
	dif.append(int(abs(global_rotation_degrees - 270)))
	dif.append(int(abs(global_rotation_degrees - 360)))
	dif.append(int(abs(global_rotation_degrees - 0)))
	for c in dif.size():
		teste = global_rotation_degrees + dif[c]
		if (teste >= -5 and teste <= 5) or (teste >= 85 and teste <= 95) or (teste >= 175 and teste <= 185) or (teste >= 265 and teste <= 275) or (teste >= 355 and teste <= 360):
			rot = teste
		c += 1
	while global_rotation_degrees != rot:
		if global_rotation_degrees < rot:
			rotate(get_physics_process_delta_time() * 10)
		if global_rotation_degrees > rot:
			rotate(get_physics_process_delta_time() * -10)


func _on_PecaL_body_entered(body: Node) -> void:
	if body.is_in_group("detector"):
		naarea = true

func _on_PeaCurva_body_entered(body: Node) -> void:
	if body.is_in_group("detector"):
		naarea = true

func _on_PeaReta_body_entered(body: Node) -> void:
	if body.is_in_group("detector"):
		naarea = true

func _on_PeaSetas_body_entered(body: Node) -> void:
	if body.is_in_group("detector"):
		naarea = true

func _on_Quadradao_body_entered(body: Node) -> void:
	if body.is_in_group("detector"):
		naarea = true
