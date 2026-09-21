# ============================================================================
# LEVEL 8 - DO YOU NEED ALL OF THEM?
# ============================================================================
# Difficulty: Medium
# Mechanics: Players must identify which pieces are actually needed.
# Challenge: 6 pieces provided, but only 4 fit; red herrings included.

extends "res://scripts/level_template.gd"

func setup_level():
	piece_scale = 0.75
	tooltip_text = "Do you need all of them?"
	
	create_sagoma(PackedVector2Array([
		Vector2(351, 549),
		Vector2(801, 549),
		Vector2(801, 249),
		Vector2(651, 249),
		Vector2(651, 99),
		Vector2(501, 99),
		Vector2(501, 249),
		Vector2(351, 249)
	]))
	
	spawn_l_shape("Pezzo_L", Vector2(250, 350), 180)
	spawn_rettangolo("Pezzo_Rect", Vector2(1000, 250), 90)
	spawn_quadrato("Pezzo_Q1", Vector2(150, 100))
	spawn_quadrato("Pezzo_Q2", Vector2(1000, 450))
	spawn_triangolo("Falso_T1", Vector2(400, 50), 0)
	spawn_triangolo("Falso_T2", Vector2(1050, 100), 180)
