extends "res://scripts/level_template.gd"

func setup_level():
	piece_scale = 0.75
	tooltip_text = "Something is strange here"
	
	create_sagoma(PackedVector2Array([
		Vector2(351, 249),
		Vector2(351, 399),
		Vector2(501, 399), 
		Vector2(501, 549),
		Vector2(576, 624),
		Vector2(651, 549), 
		Vector2(651, 399),
		Vector2(801, 399),
		Vector2(876, 324), 
		Vector2(801, 249),
		Vector2(651, 249),
		Vector2(651, 99), 
		Vector2(576, 24),
		Vector2(501, 99),
		Vector2(501, 249)
	]))
	
	spawn_rettangolo("Pezzo_Rect", Vector2(200, 550), 90)
	spawn_quadrato("Pezzo_Q1", Vector2(1000, 200))
	spawn_quadrato("Pezzo_Q2", Vector2(200, 300))
	spawn_quadrato("Pezzo_Q3", Vector2(1000, 450))
	spawn_triangolo("Pezzo_T1", Vector2(150, 150), 0)
	spawn_triangolo("Pezzo_T2", Vector2(1000, 563), 180)
	spawn_triangolo("Pezzo_T3", Vector2(1112, 450), 90)
