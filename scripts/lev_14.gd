extends "res://scripts/level_template.gd"

var sfida_iniziata: bool = false
var bottone_start: Button
var sagoma_node = null

func setup_level():
	piece_scale = 1.0
	tooltip_text = "Press it!"
	
	var punti_sagoma = PackedVector2Array([
		Vector2(650, 200),  # Punta del tetto
		Vector2(750, 300),  # Base tetto destra
		Vector2(850, 300),  # Angolo corpo destra in alto
		Vector2(850, 500),  # Angolo corpo destra in basso
		Vector2(450, 500),  # Angolo corpo sinistra in basso
		Vector2(450, 300),  # Angolo corpo sinistra in alto
		Vector2(550, 300),  # Base tetto sinistra
	])
	create_sagoma(punti_sagoma)
	
	spawn_quadrato("Pezzo_Q1", Vector2(250, 350))
	spawn_quadrato("Pezzo_Q2", Vector2(1050, 450))
	spawn_triangolo("Pezzo_T1", Vector2(1000, 150), 90)
	
	crea_pulsante_start()

func _ready():
	super._ready()
	await get_tree().process_frame
	_imposta_blocco_pezzi(true)
	for n in get_children():
		if n is Polygon2D and not n.name.begins_with("Pezzo"):
			sagoma_node = n
			break

func crea_pulsante_start():
	bottone_start = Button.new()
	bottone_start.text = "PRESS ME"
	bottone_start.position = Vector2(500, 580)
	bottone_start.custom_minimum_size = Vector2(150, 50)
	bottone_start.pressed.connect(_on_btn_start_pressed)
	$UI.add_child(bottone_start)

func _on_btn_start_pressed():
	if sfida_iniziata:
		return
	
	sfida_iniziata = true
	
	if sagoma_node:
		sagoma_node.visible = false
	
	_imposta_blocco_pezzi(false)
	
	bottone_start.visible = false

func _imposta_blocco_pezzi(bloccato: bool):
	for n in get_children():
		if n.name.begins_with("Pezzo_"):
			n.input_pickable = !bloccato

func controlla_vittoria() -> bool:
	if not sfida_iniziata:
		return false
	return super.controlla_vittoria()
