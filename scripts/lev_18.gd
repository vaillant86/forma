extends "res://scripts/level_template.gd"

var target_center := Vector2(683, 384)
var q1_spawn_pos := Vector2(1150, 520)

func setup_level():
	piece_scale = 0.72
	tooltip_text = "Less is more"

	var quadrato_esterno = PackedVector2Array([
		Vector2(483, 184),
		Vector2(867, 184),
		Vector2(867, 568),
		Vector2(483, 568)
	])
	
	var quadrato_interno = PackedVector2Array([
		Vector2(525, 225),
		Vector2(525, 545),
		Vector2(840, 545),
		Vector2(840, 225)
	])

	var coordinate_cornice = Geometry2D.clip_polygons(quadrato_esterno, quadrato_interno)
	
	if coordinate_cornice.size() > 0:
		create_sagoma(coordinate_cornice[0])
	else:
		create_sagoma(quadrato_esterno)

	spawn_rettangolo("Pezzo_R1", Vector2(130, 140), 0)
	spawn_rettangolo("Pezzo_R2", Vector2(130, 270), 0)
	spawn_rettangolo("Pezzo_R3", Vector2(1200, 140), 90)
	spawn_rettangolo("Pezzo_R4", Vector2(1200, 300), 90)
	spawn_triangolo("Pezzo_T1", Vector2(120, 520), 0)
	spawn_triangolo("Pezzo_T2", Vector2(250, 520), 90)
	spawn_quadrato("Pezzo_Q1", q1_spawn_pos)

func controlla_vittoria() -> bool:

	for n in get_children():
		if n.name.begins_with("Pezzo_") and "trascinamento" in n and n.trascinamento:
			return false

	var q1 = get_piece_by_name("Pezzo_Q1")

	if is_instance_valid(q1):
		if q1.global_position.distance_to(target_center) < 300.0:
			return false

	var required = [
		get_piece_by_name("Pezzo_R1"),
		get_piece_by_name("Pezzo_R2"),
		get_piece_by_name("Pezzo_R3"),
		get_piece_by_name("Pezzo_R4"),
		get_piece_by_name("Pezzo_T1"),
		get_piece_by_name("Pezzo_T2")
	]

	for pezzo in required:

		if not is_instance_valid(pezzo):
			return false

		var pos = pezzo.global_position

		if pos.x < 460 or pos.x > 910:
			return false

		if pos.y < 160 or pos.y > 610:
			return false

		if pos.x > 555 and pos.x < 811 and pos.y > 256 and pos.y < 512:
			return false

	return true
