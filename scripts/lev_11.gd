extends "res://scripts/level_template.gd"

func setup_level():
	piece_scale = 0.75
	
	create_sagoma(PackedVector2Array([
		Vector2(350, 150), Vector2(500, 150),
		Vector2(575, 225), Vector2(500, 300),
		Vector2(650, 300), Vector2(800, 450),
		Vector2(725, 525), Vector2(650, 450),
		Vector2(500, 450), Vector2(350, 450)
	]))
	
	spawn_rettangolo("Pezzo_Rect", Vector2(150, 400), 0)
	spawn_trapezoid("Pezzo_Trap", Vector2(1000, 500), 180)
	spawn_triangolo("Pezzo_T1", Vector2(150, 150), 0)
	spawn_triangolo("Pezzo_T2", Vector2(900, 150), 90)
	spawn_triangolo("Pezzo_T3", Vector2(1000, 300), 90)
	spawn_triangolo("Pezzo_T4", Vector2(1100, 150), 180)
	spawn_triangolo("Falso_T5", Vector2(250, 100), 180)
	spawn_rettangolo("Falso_T6", Vector2(500, 600), 90)
