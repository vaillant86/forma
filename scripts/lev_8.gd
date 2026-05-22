extends "res://scripts/base_level.gd"

func _ready():
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

	spawn_rettangolo("Pezzo_Rect", Vector2(200, 550), 90)
	spawn_quadrato("Pezzo_Q1", Vector2(1000, 200))
	spawn_quadrato("Pezzo_Q2", Vector2(200, 300))
	spawn_quadrato("Pezzo_Q3", Vector2(1000, 450))
	spawn_triangolo("Pezzo_T1", Vector2(150, 150), 0)
	spawn_triangolo("Pezzo_T2", Vector2(1000, 563), 180)
	spawn_triangolo("Pezzo_T3", Vector2(1112, 450), 90)

	var tip = Label.new()
	tip.text = "Something is strange here"
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

func spawn_triangolo(nome, pos, rot):
	var tr = Area2D.new()
	tr.set_script(load("res://scripts/triangle.gd"))
	tr.name = nome
	tr.position = pos
	tr.rotation_degrees = rot
	tr.scale = Vector2(0.75, 0.75)
	tr.set_meta("forma", "triangolo")
	add_child(tr)
