extends "res://scripts/base_level.gd"

func _ready():
	var sagoma = Polygon2D.new()
	sagoma.color = Color(0, 0, 0, 0.3)

	sagoma.polygon = PackedVector2Array([
		Vector2(351, 99), Vector2(851, 99), 
		Vector2(851, 474), Vector2(351, 474)
	])
	add_child(sagoma)

	spawn_l_shape("Pezzo_L1", Vector2(100, 200), 90)
	spawn_l_shape("Pezzo_L2", Vector2(1050, 450))
	spawn_rettangolo("Pezzo_Rect1", Vector2(400, 650), 90)
	spawn_rettangolo("Pezzo_Rect2", Vector2(1000, 650), 90)
	spawn_quadrato("Pezzo_Q1", Vector2(150, 550))
	spawn_quadrato("Pezzo_Q2", Vector2(1050, 100))

	spawn_rettangolo("Falso_Rect1", Vector2(700, 650), 90)

	var tip = Label.new()
	tip.text = "There is a liar among us"
	tip.add_theme_font_size_override("font_size", 22)
	tip.add_theme_color_override("font_color", Color(1.0, 1.0, 1.0, 0.6))
	tip.position = Vector2(1000, 660) 
	add_child(tip)

func spawn_quadrato(nome, pos):
	var p = preload("res://square.tscn").instantiate()
	p.name = nome
	p.position = pos
	p.scale = Vector2(0.625, 0.625)
	p.set_meta("forma", "quadrato")
	add_child(p)

func spawn_rettangolo(nome, pos, rot = 0.0):
	var pezzo = Area2D.new()
	pezzo.set_script(load("res://scripts/rectangle.gd"))
	pezzo.name = nome
	pezzo.position = pos
	pezzo.rotation_degrees = rot
	pezzo.scale = Vector2(0.625, 0.625)
	pezzo.set_meta("forma", "rettangolo")
	add_child(pezzo)

func spawn_l_shape(nome, pos, rot = 0.0):
	var pezzo = Area2D.new()
	pezzo.set_script(load("res://scripts/l_shape.gd"))
	pezzo.name = nome
	pezzo.position = pos
	pezzo.rotation_degrees = rot
	pezzo.scale = Vector2(0.625, 0.625)
	pezzo.set_meta("forma", "l_shape")
	add_child(pezzo)
