# ============================================================================
# LEVEL 1 - FILL THE SHAPE
# ============================================================================
# Difficulty: Easy
# Mechanics: Learn basic piece dragging and placement into a target shape.
# Challenge: None.

extends "res://scripts/level_template.gd"

func setup_level():
	grid_config = {
		"grid_step": 100.0,
		"grid_offset_x": 0.0,
		"grid_offset_y": 0.0
	}
	piece_scale = 1.0
	tooltip_text = "Fill the shape"
	
	create_sagoma(PackedVector2Array([
		Vector2(400, 200), Vector2(800, 200), Vector2(800, 400),
		Vector2(600, 400), Vector2(600, 600), Vector2(400, 600)
	]))
	
	spawn_quadrato("Pezzo_Rosso", Vector2(200, 200))
	spawn_quadrato("Pezzo_Verde", Vector2(1000, 200))
	spawn_quadrato("Pezzo_Blu", Vector2(200, 500))
