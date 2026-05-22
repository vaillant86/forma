extends "res://scripts/level_template.gd"

func setup_level():
	piece_scale = 0.75
	tooltip_text = "There is a liar among us"
	
#	create_sagoma(PackedVector2Array([
#		Vector2(350, 100),
#		Vector2(650, 100),
#		Vector2(650, 250),
#		Vector2(800, 250),
#		Vector2(800, 550),
#		Vector2(650, 550),
#		Vector2(650, 700),
#		Vector2(350, 700),
#		Vector2(350, 550),
#		Vector2(200, 550),
#		Vector2(200, 250),
#		Vector2(350, 250)
#	]))

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
		
	spawn_l_shape("Pezzo_L1", Vector2(100, 200), 90)
	spawn_l_shape("Pezzo_L2", Vector2(1025, 425))
	spawn_rettangolo("Pezzo_Rect1", Vector2(350, 600), 90)
	spawn_rettangolo("Pezzo_Rect2", Vector2(1050, 600), 90)
	spawn_quadrato("Pezzo_Q1", Vector2(850, 100))
	spawn_quadrato("Pezzo_Q2", Vector2(1050, 100))
	spawn_rettangolo("Falso_Rect1", Vector2(700, 600), 90)
