extends "res://scripts/level_template.gd"

func setup_level():
	piece_scale = 0.75
	tooltip_text = "There is a liar among us"
	
	create_sagoma(PackedVector2Array([
		Vector2(400, 50),
		Vector2(700, 50),
		Vector2(700, 200),
		Vector2(850, 200),
		Vector2(850, 500),
		Vector2(700, 500),
		Vector2(700, 650),
		Vector2(400, 650),
		Vector2(400, 500),
		Vector2(250, 500),
		Vector2(250, 200),
		Vector2(400, 200)
	]))
		
	spawn_l_shape("Pezzo_L1", Vector2(100, 100), 90)
	spawn_l_shape("Pezzo_L2", Vector2(1000, 425))
	spawn_rettangolo("Pezzo_Rect1", Vector2(150, 600), 90)
	spawn_rettangolo("Pezzo_Rect2", Vector2(850, 600), 90)
	spawn_quadrato("Pezzo_Q1", Vector2(850, 100))
	spawn_quadrato("Pezzo_Q2", Vector2(1050, 100))
	spawn_rettangolo("Falso_Rect1", Vector2(500, 600), 90)
