# ============================================================================
# LEVEL 18 - LESS IS MORE
# ============================================================================
# Difficulty: Expert
# Mechanics: Target is a frame, not a square.
# Challenge: Fill the border around a central void.

extends "res://scripts/level_template.gd"

var active_pieces: Array = []

var targets = [
	{
		"node": "Pezzo_R1",
		"pos": Vector2(533.0, 309.0),
		"rot": 0.0
	},
	{
		"node": "Pezzo_R2",
		"pos": Vector2(608.0, 534.0),
		"rot": 90.0
	},
	{
		"node": "Pezzo_R3",
		"pos": Vector2(833.0, 459.0),
		"rot": 0.0
	},
	{
		"node": "Pezzo_R4",
		"pos": Vector2(758.0, 234.0),
		"rot": 90.0
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
	spawn_quadrato("Pezzo_Q1", Vector2(608, 309))


func _ready():
	super._ready()
	await get_tree().process_frame
	for n in get_children():
		if n.name.begins_with("Pezzo_"):
			active_pieces.append(n)

func _process(delta):
	super._process(delta)

	for t in targets:

		if t["pos"] == Vector2.ZERO:
			continue

		var p = get_piece_by_name(t["node"])

		if not is_instance_valid(p):
			continue

		if p.trascinamento:
			continue

		var rot = wrapf(p.rotation_degrees, 0.0, 360.0)
		var target_rot = wrapf(t["rot"], 0.0, 360.0)

		if p.global_position.distance_to(t["pos"]) < 15.0 \
		and abs(rot - target_rot) < 5.0:

			p.global_position = t["pos"]
			p.rotation_degrees = t["rot"]
			
func controlla_vittoria() -> bool:
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

	for p in active_pieces:

		if not is_instance_valid(p):
			return false

		if p.trascinamento:
			return false

	for slot in slots:
		var trovato = false
		for p in active_pieces:
			if p.global_position.distance_to(slot["pos"]) > 5.0:
				continue

			var rot = wrapf(p.rotation_degrees, 0.0, 360.0)

			var verticale = (
				abs(rot - 90.0) < 5.0
				or abs(rot - 270.0) < 5.0
			)

			var orizzontale = (
				abs(rot - 0.0) < 5.0
				or abs(rot - 180.0) < 5.0
			)

			if slot["verticale"] and verticale:
				trovato = true
				break

			if not slot["verticale"] and orizzontale:
				trovato = true
				break

		if not trovato:
			return false

	return true
