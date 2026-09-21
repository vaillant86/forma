# ============================================================================
# LEVEL 4 - A NEW PIECE JOINS THE PARTY
# ============================================================================
# Difficulty: Easy
# Mechanics: Introduction to the trapezoid piece type (5th unique shape).
# Challenge: Complex 10-point target; players must figure out how 5 pieces fit together.

extends "res://scripts/level_template.gd"

func setup_level():
	grid_config = {
		"grid_step": 100.0,
		"grid_offset_x": 0.0,
		"grid_offset_y": 0.0
	}
	piece_scale = 0.75
	tooltip_text = "A new piece joins the party"
	
	create_sagoma(PackedVector2Array([
		Vector2(426, 124),
		Vector2(726, 124),
		Vector2(726, 274),
		Vector2(576, 274),
		Vector2(726, 424),
		Vector2(726, 574),
		Vector2(426, 574),
		Vector2(426, 424),
		Vector2(576, 424),
		Vector2(426, 274)
	]))
	
	spawn_quadrato("Pezzo_Rosso", Vector2(150, 124))
	spawn_quadrato("Pezzo_Verde", Vector2(150, 524))
	spawn_quadrato("Pezzo_Blu", Vector2(980, 124))
	spawn_quadrato("Pezzo_Giallo", Vector2(980, 524))
	spawn_trapezoid("Pezzo_IR", Vector2(980, 324))
