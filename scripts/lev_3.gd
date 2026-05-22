extends "res://scripts/level_template.gd"

func setup_level():
	grid_config = {
		"grid_step": 100.0,
		"grid_offset_x": 0.0,
		"grid_offset_y": 0.0
	}
	piece_scale = 1.0
	tooltip_text = "Right-click on a piece to rotate it"
	
	create_sagoma(PackedVector2Array([
		Vector2(400, 500),
		Vector2(600, 500),
		Vector2(600, 300), 
		Vector2(700, 300),
		Vector2(500, 100),
		Vector2(300, 300), 
		Vector2(400, 300)
	]))
	
	var sq = preload("res://square.tscn").instantiate()
	sq.name = "Pezzo_Base"
	sq.position = Vector2(150, 450)
	sq.modulate = Color.MEDIUM_SLATE_BLUE
	sq.scale = Vector2(piece_scale, piece_scale)
	sq.set_meta("forma", "quadrato")
	add_child(sq)
	
	spawn_triangolo("Pezzo_T1", Vector2(850, 150), 90)
	spawn_triangolo("Pezzo_T2", Vector2(1050, 150), 0)
	spawn_triangolo("Pezzo_T3", Vector2(950, 300), 90)
	spawn_triangolo("Pezzo_T4", Vector2(950, 500), 180)
