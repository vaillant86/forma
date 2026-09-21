# ============================================================================
# LEVEL 5 - STEP BY STEP
# ============================================================================
# Difficulty: Easy
# Mechanics: Reinforces piece variety (square, rectangle, L-shape).
# Challenge: Staircase target requires careful thinking; pieces must stack precisely.

extends "res://scripts/level_template.gd"

func setup_level():
	piece_scale = 0.75
	tooltip_text = "Step by step"
	
	create_sagoma(PackedVector2Array([
		Vector2(351, 549),
		Vector2(801, 549),
		Vector2(801, 399),
		Vector2(651, 399),
		Vector2(651, 249),
		Vector2(501, 249),
		Vector2(501, 99),
		Vector2(351, 99)
	]))
	
	spawn_quadrato("Pezzo_Rosso", Vector2(150, 500))
	spawn_rettangolo("Pezzo_Rect", Vector2(900, 200))
	spawn_l_shape("Pezzo_L", Vector2(950, 450), 90)
