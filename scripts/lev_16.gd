extends "res://scripts/level_template.gd"

var center_x: float = 683.0
var piece_left: Node2D
var piece_right: Node2D

func setup_level():
	piece_scale = 1.0
	tooltip_text = "Reflections walk different paths"
	
	spawn_quadrato("Pezzo_Main", Vector2(200, 384))
	spawn_quadrato("Pezzo_Extra", Vector2(1166, 384))

func _ready():
	super._ready()
	await get_tree().process_frame
	piece_left = get_node_or_null("Pezzo_Main")
	piece_right = get_node_or_null("Pezzo_Extra")
	grid_step = 0.0
	raggio_calamita = 0.0

func _process(_delta):
	if not griglia_calcolata:
		calcola_griglia_automatica()
		imposta_interfaccia()
		gioco_attivo = true
	
	if gioco_attivo:
		if controlla_vittoria():
			gestisci_vittoria()
	
	if piece_left and piece_right:
		if "trascinamento" in piece_left and piece_left.trascinamento:
			var dist = center_x - piece_left.position.x
			var new_right_x = clamp(center_x + dist, center_x + 100, 1316)
			new_right_x = max(new_right_x, piece_left.position.x + 200)
			piece_right.position.x = new_right_x
			piece_right.position.y = piece_left.position.y
		elif "trascinamento" in piece_right and piece_right.trascinamento:
			var dist = piece_right.position.x - center_x
			var new_left_x = clamp(center_x - dist, 50, center_x - 100)
			new_left_x = min(new_left_x, piece_right.position.x - 200)
			piece_left.position.x = new_left_x
			piece_left.position.y = piece_right.position.y
						
func controlla_vittoria() -> bool:
	if not (piece_left and piece_right):
		return false
	if ("trascinamento" in piece_left and piece_left.trascinamento) or \
	   ("trascinamento" in piece_right and piece_right.trascinamento):
		return false

	var same_y = abs(piece_left.position.y - piece_right.position.y) < 2.0
	var touching_x = abs(piece_right.position.x - piece_left.position.x) < 202.0
	
	return same_y and touching_x

func center_sagoma():
	pass
