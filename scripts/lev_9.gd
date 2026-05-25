extends "res://scripts/level_template.gd"

func setup_level():
	piece_scale = 0.75
	tooltip_text = "Keep going"
	
	create_sagoma(PackedVector2Array([
		Vector2(351, 549),
		Vector2(801, 549),
		Vector2(801, 249),
		Vector2(726, 174),
		Vector2(651, 249),
		Vector2(576, 174),
		Vector2(501, 249),
		Vector2(501, 99),
		Vector2(351, 99)
	]))
	
	spawn_l_shape("Pezzo_L", Vector2(100, 450))
	spawn_rettangolo("Pezzo_Rect", Vector2(1000, 200))
	spawn_quadrato("Pezzo_Q1", Vector2(700, 50))
	spawn_quadrato("Pezzo_Q2", Vector2(1100, 500))
	spawn_triangolo("Pezzo_T1", Vector2(50, 50), 270)
	spawn_triangolo("Pezzo_T2", Vector2(200, 100), 90)
