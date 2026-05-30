# ============================================================================
# LEVEL 15 - OPPOSITES ATTRACT (PHYSICS-BASED CHALLENGE)
# ============================================================================
# Difficulty: Hard
# Mechanics: Pieces are attracted to center point.
# Challenge: Three pieces with gravity toward center.

extends "res://scripts/level_template.gd"

var magnet_center: Vector2 = Vector2(683, 384)
var magnet_strength: float = 400.0
var active_pieces: Array = []

var slots: Array[Vector2] = [
	Vector2(483, 384),
	Vector2(683, 384),
	Vector2(883, 384)
]
var snap_threshold: float = 10.0

func setup_level():
	piece_scale = 1.0
	tooltip_text = "Opposites attract"
	
	var punti_sagoma = PackedVector2Array([
		Vector2(383, 284),
		Vector2(983, 284),
		Vector2(983, 484),
		Vector2(383, 484)
	])
	create_sagoma(punti_sagoma)
	
	spawn_quadrato("Pezzo_1", Vector2(683, 384))
	spawn_quadrato("Pezzo_2", Vector2(683, 384))
	spawn_quadrato("Pezzo_3", Vector2(683, 384))

func _ready():
	super._ready()
	await get_tree().process_frame
	grid_step = 0.0

	for n in get_children():
		if n.name.begins_with("Pezzo_"):
			active_pieces.append(n)

func calcola_griglia_automatica():
	super.calcola_griglia_automatica()
	grid_step = 0.0

func _process(delta):
	super._process(delta)
	for pezzo in active_pieces:
		if "trascinamento" in pezzo and pezzo.trascinamento:
			continue
		
		var snapped: bool = false
		for target_pos in slots:
			if pezzo.position.distance_to(target_pos) < snap_threshold:
				pezzo.position = target_pos
				snapped = true
				break
		
		if snapped:
			continue
		
		var direction = (magnet_center - pezzo.position).normalized()
		pezzo.position += direction * magnet_strength * delta
				
func controlla_vittoria() -> bool:
	for pezzo in active_pieces:
		if "trascinamento" in pezzo and pezzo.trascinamento:
			return false
	
	var occupied_slots: int = 0
	for target_pos in slots:
		for pezzo in active_pieces:
			if pezzo.position.distance_to(target_pos) < 2.0:
				occupied_slots += 1
				break
	
	if occupied_slots < slots.size():
		return false
	
	return true
