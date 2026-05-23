extends "res://scripts/level_template.gd"

var magnet_center: Vector2 = Vector2(640, 360)
var magnet_strength: float = 150.0
var active_pieces: Array = []

var slots: Array[Vector2] = [
	Vector2(440, 360),
	Vector2(640, 360),
	Vector2(840, 360)
]
var snap_threshold: float = 25.0

func setup_level():
	piece_scale = 1.0
	tooltip_text = "Opposites attract"
	
	var punti_sagoma = PackedVector2Array([
		Vector2(340, 260),
		Vector2(940, 260),
		Vector2(940, 460),
		Vector2(340, 460)
	])
	create_sagoma(punti_sagoma)
	
	spawn_quadrato("Pezzo_1", Vector2(340, 200))
	spawn_quadrato("Pezzo_2", Vector2(640, 600))
	spawn_quadrato("Pezzo_3", Vector2(940, 200))

func _ready():
	super._ready()
	await get_tree().process_frame
	
	for n in get_children():
		if n.name.begins_with("Pezzo_"):
			active_pieces.append(n)

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
	
	return super.controlla_vittoria()
