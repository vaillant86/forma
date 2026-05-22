extends "res://scripts/level_template.gd"

func setup_level():
	piece_scale = 0.75
	
	create_sagoma(PackedVector2Array([
		Vector2(400, 200), Vector2(850, 200),
		Vector2(850, 500), Vector2(400, 500)
	]))
	
	# Initial triangles
	spawn_triangolo("Pezzo_T1", Vector2(100, 100), 0)
	spawn_triangolo("Pezzo_T2", Vector2(100, 250), 90)
	spawn_triangolo("Pezzo_T3", Vector2(100, 400), 180)
	spawn_triangolo("Pezzo_T4", Vector2(100, 550), 90)
	
	# Initial rectangles
	spawn_rettangolo("Pezzo_R1", Vector2(1000, 100), 90)
	spawn_rettangolo("Pezzo_R2", Vector2(500, 100), 90)
	
	# Square
	spawn_quadrato("Pezzo_Q1", Vector2(1000, 400))
	
	# Transformable trapezoid
	spawn_transformable_trapezoid("Pezzo_TR1", Vector2(1000, 550))

func spawn_transformable_trapezoid(nome: String, pos: Vector2):
	"""Spawn a trapezoid that transforms to rectangle on right-click."""
	var pezzo = spawn_trapezoid(nome, pos)
	pezzo.input_pickable = true
	
	pezzo.input_event.connect(func(viewport, event, shape_idx):
		if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
			_transform_trapezoid_to_rectangle(pezzo)
	)

func _transform_trapezoid_to_rectangle(trapezoid_node: Area2D):
	"""Transform trapezoid to rectangle piece."""
	if is_instance_valid(trapezoid_node):
		var pos = trapezoid_node.position
		var rot = trapezoid_node.rotation_degrees
		
		spawn_rettangolo("Pezzo_R_Vero", pos, rot)
		trapezoid_node.queue_free()

func controlla_vittoria() -> bool:
	"""Win condition: Must have all required pieces."""
	# 1. Check if player is still dragging
	for n in get_children():
		if n.name.begins_with("Pezzo_") and "trascinamento" in n and n.trascinamento:
			return false

	# 2. Get required pieces
	var t1 = get_node_or_null("Pezzo_T1")
	var t2 = get_node_or_null("Pezzo_T2")
	var t3 = get_node_or_null("Pezzo_T3")
	var t4 = get_node_or_null("Pezzo_T4")
	var q1 = get_node_or_null("Pezzo_Q1")
	var r1 = get_node_or_null("Pezzo_R1")
	var r3 = get_node_or_null("Pezzo_R_Vero")

	# Must have BOTH rectangles (R1 and R3, not R2)
	if not (is_instance_valid(r1) and is_instance_valid(r3)):
		return false

	# Check all required pieces
	var required_pieces = [t1, t2, t3, t4, q1, r1, r3]
	
	for pezzo in required_pieces:
		if not is_instance_valid(pezzo):
			return false
		
		# Check position is within sagoma bounds (400x200 to 850x500)
		var pos = pezzo.global_position
		if pos.x < 390 or pos.x > 860 or pos.y < 190 or pos.y > 510:
			return false

	return true
