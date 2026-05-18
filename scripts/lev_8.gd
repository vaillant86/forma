extends "res://scripts/base_level.gd"

func _ready():
	# Sagoma a forma di nave spaziale o enorme freccia
	var sagoma = Polygon2D.new()
	sagoma.color = Color(0, 0, 0, 0.3)
	sagoma.polygon = PackedVector2Array([
		Vector2(351, 249), Vector2(351, 399), Vector2(501, 399), 
		Vector2(501, 549), Vector2(576, 624), Vector2(651, 549), 
		Vector2(651, 399), Vector2(801, 399), Vector2(876, 324), 
		Vector2(801, 249), Vector2(651, 249), Vector2(651, 99), 
		Vector2(576, 24),  Vector2(501, 99),  Vector2(501, 249)
	])
	add_child(sagoma)

	# Spawn dei pezzi
	spawn_rettangolo("Pezzo_Rect", Vector2(200, 550), Color.DARK_TURQUOISE, 90)
	spawn_quadrato("Pezzo_Q1", Vector2(100, 100), Color.CRIMSON)
	spawn_quadrato("Pezzo_Q2", Vector2(200, 300), Color.GOLD)
	spawn_quadrato("Pezzo_Q3", Vector2(1000, 450), Color.MEDIUM_PURPLE)
	spawn_triangolo("Pezzo_T1", Vector2(1000, 150), Color.CORAL, 0)
	spawn_triangolo("Pezzo_T2", Vector2(1000, 250), Color.CHARTREUSE, 180)
	spawn_triangolo("Pezzo_T3", Vector2(800, 550), Color.AQUA, 90)

# --- FUNZIONI DI SPAWN ---
func spawn_quadrato(nome, pos, colore):
	var p = preload("res://square.tscn").instantiate()
	p.name = nome
	p.position = pos
	p.modulate = colore
	p.scale = Vector2(0.75, 0.75)
	p.set_meta("forma", "quadrato")
	add_child(p)

func spawn_rettangolo(nome, pos, colore, rot = 0.0):
	var pezzo = Area2D.new()
	pezzo.set_script(load("res://scripts/rectangle.gd"))
	pezzo.name = nome
	pezzo.position = pos
	pezzo.modulate = colore
	pezzo.rotation_degrees = rot
	pezzo.scale = Vector2(0.75, 0.75)
	pezzo.set_meta("forma", "rettangolo")
	add_child(pezzo)

func spawn_triangolo(nome, pos, colore, rot):
	var tr = Area2D.new()
	tr.set_script(load("res://scripts/triangle.gd"))
	tr.name = nome
	tr.position = pos
	tr.modulate = colore
	tr.rotation_degrees = rot
	tr.scale = Vector2(0.75, 0.75)
	tr.set_meta("forma", "triangolo")
	add_child(tr)
