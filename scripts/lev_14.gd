extends "res://scripts/level_template.gd"

var sfondo_invertito: bool = false
var bottone_colore: Button

var posizioni_disordinate: Dictionary = {}

func setup_level():
	piece_scale = 1.0
	tooltip_text = "Hidden in plain sight"
	
	var punti_sagoma = PackedVector2Array([
		Vector2(450, 250),
		Vector2(850, 250),
		Vector2(850, 450),
		Vector2(450, 450)
	])
	create_sagoma(punti_sagoma)
	
	spawn_quadrato("Pezzo_Main", Vector2(150, 350))
	spawn_quadrato("Pezzo_Extra", Vector2(1050, 350))
	
	crea_pulsante_colore()

func _ready():
	super._ready()
	await get_tree().process_frame
	_genera_posizioni_disordinate()

func _genera_posizioni_disordinate():
	var zone_caos = [
		Rect2(50, 150, 300, 400),   # Zona sinistra
		Rect2(850, 150, 300, 400),  # Zona destra
		Rect2(150, 500, 600, 150),  # Zona in basso
	]
	for n in get_children():
		if n.name.begins_with("Pezzo_"):
			var zona = zone_caos[randi() % zone_caos.size()]
			posizioni_disordinate[n.name] = Vector2(
				randf_range(zona.position.x, zona.position.x + zona.size.x),
				randf_range(zona.position.y, zona.position.y + zona.size.y)
			)

func crea_pulsante_colore():
	bottone_colore = Button.new()
	bottone_colore.text = "CHANGE COLOR"
	bottone_colore.position = Vector2(500, 580)
	bottone_colore.custom_minimum_size = Vector2(150, 50)
	bottone_colore.pressed.connect(_on_btn_invert_color_pressed)
	$UI.add_child(bottone_colore)

func _on_btn_invert_color_pressed():
	sfondo_invertito = !sfondo_invertito

	var elemento_visivo = null
	if $LevelBackground.get_child_count() > 0:
		elemento_visivo = $LevelBackground.get_child(0)
	var target_colore = elemento_visivo if elemento_visivo != null else $LevelBackground

	if sfondo_invertito:
		# Lo sfondo cambia colore (es. diventa scuro)
		target_colore.modulate = Color(0.2, 0.2, 0.3)
		bottone_colore.text = "CHANGE COLOR"
		
		# I pezzi diventano TRASPARENTI AL 100% (Invisibili, ma cliccabili!)
		for n in get_children():
			if n.name.begins_with("Pezzo_"):
				n.modulate.a = 0.0 # Alpha a 0 = invisibile al giocatore
	else:
		# Lo sfondo torna normale
		target_colore.modulate = Color(1.0, 1.0, 1.0)
		bottone_colore.text = "CHANGE COLOR"
		
		# I pezzi tornano visibili e si rimescolano nel caos
		for n in get_children():
			if n.name.begins_with("Pezzo_"):
				n.modulate.a = 1.0 # Alpha a 1 = torna visibile
				
				# Punizione: cambiano posizione
				if posizioni_disordinate.has(n.name):
					n.position = posizioni_disordinate[n.name]
				
				_rigenera_posizione_disordinata(n)
func _rigenera_posizione_disordinata(pezzo):
	var zone_caos = [
		Rect2(50, 150, 300, 400),
		Rect2(850, 150, 300, 400),
		Rect2(150, 500, 600, 150),
	]
	var zona = zone_caos[randi() % zone_caos.size()]
	posizioni_disordinate[pezzo.name] = Vector2(
		randf_range(zona.position.x, zona.position.x + zona.size.x),
		randf_range(zona.position.y, zona.position.y + zona.size.y)
	)

func controlla_vittoria() -> bool:
	if not sfondo_invertito:
		return false
	return super.controlla_vittoria()
