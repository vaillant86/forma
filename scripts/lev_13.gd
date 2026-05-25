extends "res://scripts/level_template.gd"

func setup_level():
	piece_scale = 0.75
	tooltip_text = "Hidden in plain sight"
	
	create_sagoma(PackedVector2Array([
		Vector2(400, 200), Vector2(850, 200),
		Vector2(850, 500), Vector2(400, 500)
	]))
	
	spawn_triangolo("Pezzo_T1", Vector2(150, 100), 0)
	spawn_triangolo("Pezzo_T2", Vector2(150, 250), 90)
	spawn_triangolo("Pezzo_T3", Vector2(150, 400), 180)
	spawn_triangolo("Pezzo_T4", Vector2(150, 550), 90)
	
	spawn_rettangolo("Pezzo_R1", Vector2(1100, 100), 90)
	spawn_rettangolo("Pezzo_R2", Vector2(500, 100), 90)
	
	spawn_quadrato("Pezzo_Q1", Vector2(1000, 350))
	
	spawn_transformable_trapezoid("Pezzo_TR1", Vector2(1000, 550))

func spawn_transformable_trapezoid(nome: String, pos: Vector2):
	var pezzo = spawn_trapezoid(nome, pos)
	pezzo.input_pickable = true
	
	pezzo.input_event.connect(func(viewport, event, shape_idx):
		if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
			_transform_trapezoid_to_rectangle(pezzo)
	)

func _transform_trapezoid_to_rectangle(trapezoid_node: Area2D):
	if is_instance_valid(trapezoid_node):
		var pos = trapezoid_node.position
		var rot = trapezoid_node.rotation_degrees

		var fake_r = get_node_or_null("Pezzo_R2")
		if is_instance_valid(fake_r):
			fake_r.queue_free()
		
		var real_r = spawn_rettangolo("Pezzo_R_Vero", pos, rot)
		real_r.input_pickable = true
		
		trapezoid_node.queue_free()

func controlla_vittoria() -> bool:
	for n in get_children():
		if n.name == "Pezzo_R2":
			continue

		if n.name.begins_with("Pezzo_") and "trascinamento" in n and n.trascinamento:
			return false

	var t1 = get_node_or_null("Pezzo_T1")
	var t2 = get_node_or_null("Pezzo_T2")
	var t3 = get_node_or_null("Pezzo_T3")
	var t4 = get_node_or_null("Pezzo_T4")
	var q1 = get_node_or_null("Pezzo_Q1")
	var r1 = get_node_or_null("Pezzo_R1")
	var r3 = get_node_or_null("Pezzo_R_Vero")

	if not is_instance_valid(r3):
		return false

	var required_pieces = [t1, t2, t3, t4, q1, r1, r3]
	
	for pezzo in required_pieces:
		if not is_instance_valid(pezzo):
			return false
		
		var pos = pezzo.global_position
		if pos.x < 390 or pos.x > 860 or pos.y < 190 or pos.y > 510:
			return false

	return true
