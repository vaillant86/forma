extends "res://scripts/level_template.gd"

func setup_level():
	piece_scale = 0.75
	tooltip_text = "There is a liar among us"
	
	create_sagoma(PackedVector2Array([
		Vector2(351, 99), Vector2(851, 99), 
		Vector2(851, 474), Vector2(351, 474)
	]))
	
	spawn_l_shape("Pezzo_L1", Vector2(100, 200), 90)
	spawn_l_shape("Pezzo_L2", Vector2(1050, 450))
	spawn_rettangolo("Pezzo_Rect1", Vector2(400, 650), 90)
	spawn_rettangolo("Pezzo_Rect2", Vector2(1000, 650), 90)
	spawn_quadrato("Pezzo_Q1", Vector2(150, 550))
	spawn_quadrato("Pezzo_Q2", Vector2(1050, 100))
	spawn_rettangolo("Falso_Rect1", Vector2(700, 650), 90)
