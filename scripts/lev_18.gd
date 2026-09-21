# ============================================================================
# LEVEL 18 - LESS IS MORE
# ============================================================================
# Difficulty: Expert
# Mechanics: Puzzle targets border placement inside a solid square silhouette.
# Challenge: Fill the border around a central void.

extends "res://scripts/level_template.gd"

var active_pieces: Array = []

var slots = [
	{
		"pos": Vector2(533.0, 309.0),
		"verticale": false
	},
	{
		"pos": Vector2(608.0, 534.0),
		"verticale": true
	},
	{
		"pos": Vector2(833.0, 459.0),
		"verticale": false
	},
	{
		"pos": Vector2(758.0, 234.0),
		"verticale": true
	}
]

func setup_level():
	tooltip_text = "Less is more"
	piece_scale = 0.75
	grid_step = 0.0
	grid_offset_x = 0.0
	grid_offset_y = 0.0

	var punti_sagoma = PackedVector2Array([
		Vector2(383, 84),
		Vector2(833, 84),
		Vector2(833, 534),
		Vector2(383, 534)
	])

	create_sagoma(punti_sagoma)

	spawn_rettangolo("Pezzo_R1", Vector2(100, 200), 0)
	spawn_rettangolo("Pezzo_R2", Vector2(150, 500), 90)
	spawn_rettangolo("Pezzo_R3", Vector2(1000, 200), 0)
	spawn_rettangolo("Pezzo_R4", Vector2(1050, 500), 90)

func _ready():
	super._ready()
	await get_tree().process_frame
	for n in get_children():
		if n.name.begins_with("Pezzo_"):
			active_pieces.append(n)

func _process(delta):
	super._process(delta)

func controlla_vittoria() -> bool:
	for p in active_pieces:
		if not is_instance_valid(p) or p.trascinamento:
			return false

	var used_pieces: Array = []

	for slot in slots:
		var found_piece = null
		
		for p in active_pieces:
			if p in used_pieces:
				continue

			if p.global_position.distance_to(slot["pos"]) > 18.0:
				continue

			var rot = fmod(abs(p.rotation_degrees), 180.0)
			if rot > 90.0:
				rot = 180.0 - rot

			var is_horizontal = rot < 6.0
			var is_vertical = abs(rot - 90.0) < 6.0

			if slot["verticale"] and is_vertical:
				found_piece = p
				break
			elif not slot["verticale"] and is_horizontal:
				found_piece = p
				break

		if found_piece != null:
			used_pieces.append(found_piece)
		else:
			return false

	return used_pieces.size() == slots.size()
