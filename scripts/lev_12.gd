extends "res://scripts/base_level.gd"

func _ready():
	var sagoma = Polygon2D.new()
	sagoma.color = Color(0, 0, 0, 0.3)
	sagoma.polygon = PackedVector2Array([
		Vector2(350, 200),   # In alto a sinistra
		Vector2(800, 200),   # In alto a destra
		Vector2(800, 500),   # In basso a destra
		Vector2(350, 500)    # In basso a sinistra
	])
	add_child(sagoma)
	
	# I tuoi 3 pezzi con la tua esatta logica di spawn
	spawn_l_shape("Pezzo_L", Vector2(100, 550))
	spawn_rettangolo("Pezzo_Rect", Vector2(1000, 200), 90)
	spawn_quadrato("Pezzo_Q2", Vector2(1100, 500))

	move_child(sagoma, 0)

	var tip = Label.new()
	tip.text = "Be quiet please..."
	tip.add_theme_font_size_override("font_size", 22)
	tip.add_theme_color_override("font_color", Color(1.0, 1.0, 1.0, 0.6))
	tip.position = Vector2(900, 660) 
	add_child(tip)

func spawn_quadrato(nome, pos):
	var p = preload("res://square.tscn").instantiate()
	p.name = nome
	p.position = pos
	p.scale = Vector2(0.75, 0.75)
	p.set_meta("forma", "quadrato")
	add_child(p)

func spawn_rettangolo(nome, pos, rot = 0.0):
	var pezzo = Area2D.new()
	pezzo.set_script(load("res://scripts/rectangle.gd"))
	pezzo.name = nome
	pezzo.position = pos
	pezzo.rotation_degrees = rot
	pezzo.scale = Vector2(0.75, 0.75)
	pezzo.set_meta("forma", "rettangolo")
	add_child(pezzo)

func spawn_l_shape(nome, pos, rot = 0.0):
	var pezzo = Area2D.new()
	pezzo.set_script(load("res://scripts/l_shape.gd"))
	pezzo.name = nome
	pezzo.position = pos
	pezzo.rotation_degrees = rot
	pezzo.scale = Vector2(0.75, 0.75)
	pezzo.set_meta("forma", "l_shape")
	add_child(pezzo)

func controlla_vittoria() -> bool:
	var pezzi_corretti = super.controlla_vittoria()
	var audio_muto = AudioServer.is_bus_mute(AudioServer.get_bus_index("Master"))
	return pezzi_corretti and audio_muto
