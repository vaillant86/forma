extends "res://scripts/level_template.gd"

func setup_level():
	grid_config = {
		"grid_step": 100.0,
		"grid_offset_x": 0.0,
		"grid_offset_y": 0.0
	}
	piece_scale = 0.75
	
	create_sagoma(PackedVector2Array([
		Vector2(376,  24), Vector2(776,  24), Vector2(776, 224),
		Vector2(576, 224), Vector2(776, 424),
		Vector2(776, 624), Vector2(376, 624), Vector2(376, 424),
		Vector2(576, 424), Vector2(376, 224)
	]))
	
	spawn_quadrato("Pezzo_Rosso", Vector2(150, 124))
	spawn_quadrato("Pezzo_Verde", Vector2(150, 524))
	spawn_quadrato("Pezzo_Blu", Vector2(980, 124))
	spawn_quadrato("Pezzo_Giallo", Vector2(980, 524))
	spawn_trapezoid("Pezzo_IR", Vector2(980, 324))
