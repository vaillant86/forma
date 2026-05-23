extends "res://scripts/level_template.gd"

func setup_level():
	piece_scale = 0.75
	tooltip_text = "Leave something behind"
	
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
	
	spawn_l_shape("Pezzo_L", Vector2(100, 550))
	spawn_rettangolo("Pezzo_Rect", Vector2(1000, 200), 90)
	spawn_quadrato("Pezzo_Q1", Vector2(900, 600))
	spawn_quadrato("Pezzo_Q2", Vector2(1100, 500))
	spawn_triangolo("Pezzo_T1", Vector2(150, 100), 270)
	spawn_triangolo("Pezzo_T2", Vector2(250, 250), 90)
