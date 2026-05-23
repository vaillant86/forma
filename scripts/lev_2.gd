extends "res://scripts/level_template.gd"

func setup_level():
	grid_config = {
		"grid_step": 100.0,
		"grid_offset_x": 0.0,
		"grid_offset_y": 0.0
	}
	piece_scale = 1.0
	tooltip_text = "Every corner counts"
	
	create_sagoma(PackedVector2Array([
		Vector2(300, 200), Vector2(900, 200), Vector2(900, 400),
		Vector2(700, 400), Vector2(700, 600), Vector2(500, 600),
		Vector2(500, 400), Vector2(300, 400)
	]))
	
	spawn_quadrato("Pezzo_Rosso", Vector2(150, 150))
	spawn_quadrato("Pezzo_Verde", Vector2(150, 500))
	spawn_quadrato("Pezzo_Blu", Vector2(1050, 150))
	spawn_quadrato("Pezzo_Giallo", Vector2(1050, 500))
