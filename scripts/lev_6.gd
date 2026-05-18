extends "res://scripts/base_level.gd"

func _ready():
	var sagoma = Polygon2D.new()
	sagoma.color = Color(0, 0, 0, 0.3)
	sagoma.polygon = PackedVector2Array([
		Vector2(351, 549), Vector2(801, 549), Vector2(801, 249),
		Vector2(726, 174), Vector2(651, 249), Vector2(576, 174),
		Vector2(501, 249), Vector2(501, 99),  Vector2(351, 99),
		Vector2(351, 549)
	])
	add_child(sagoma)

	spawn_l_shape("Pezzo_L", Vector2(100, 550))
	spawn_rettangolo("Pezzo_Rect", Vector2(1000, 200), 90)
	spawn_quadrato("Pezzo_Q1", Vector2(900, 600))
	spawn_quadrato("Pezzo_Q2", Vector2(1100, 500))
	spawn_triangolo("Pezzo_T1", Vector2(150, 100), 270)
	spawn_triangolo("Pezzo_T2", Vector2(250, 250), 90)

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

func spawn_triangolo(nome, pos, rot):
	var tr = Area2D.new()
	tr.set_script(load("res://scripts/triangle.gd"))
	tr.name = nome
	tr.position = pos
	tr.rotation_degrees = rot
	tr.scale = Vector2(0.75, 0.75)
	tr.set_meta("forma", "triangolo")
	add_child(tr)
