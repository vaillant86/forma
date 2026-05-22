extends "res://scripts/level_template.gd"

func setup_level():
	piece_scale = 0.75
	
	create_sagoma(PackedVector2Array([
		Vector2(501, 174),
		Vector2(576, 249),
		Vector2(651, 174), 
		Vector2(726, 249),
		Vector2(726, 549),
		Vector2(651, 624), 
		Vector2(576, 549),
		Vector2(501, 624),
		Vector2(426, 549), 
		Vector2(426, 249)
	]))
	
	spawn_l_shape("Pezzo_L", Vector2(150, 350))
	spawn_quadrato("Pezzo_Q", Vector2(1000, 550))
	spawn_triangolo("Pezzo_T1", Vector2(150, 550), 270)
	spawn_triangolo("Pezzo_T2", Vector2(850, 100), 90)
	spawn_triangolo("Pezzo_T3", Vector2(1000, 150), 0)
	spawn_triangolo("Pezzo_T4", Vector2(1100, 350), 180)
