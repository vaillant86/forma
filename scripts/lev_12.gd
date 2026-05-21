extends "res://scripts/base_level.gd"

func _ready():
	var sagoma = Polygon2D.new()
	sagoma.color = Color(0, 0, 0, 0.3)
	
	# Forma target complessa: un esagono irregolare con intacchi
	sagoma.polygon = PackedVector2Array([
		Vector2(350, 200),   # Top left
		Vector2(550, 150),   # Top center
		Vector2(700, 200),   # Top right
		Vector2(750, 350),   # Right upper
		Vector2(700, 500),   # Right lower
		Vector2(550, 550),   # Bottom right
		Vector2(350, 550),   # Bottom left
		Vector2(200, 500),   # Left lower
		Vector2(150, 350),   # Left upper
	])
	add_child(sagoma)

	# Pezzi corretti
	spawn_triangolo("Pezzo_T1", Vector2(100, 100), 0)
	spawn_triangolo("Pezzo_T2", Vector2(900, 100), 45)
	spawn_rettangolo("Pezzo_R1", Vector2(100, 500), 0)
	spawn_l_shape("Pezzo_L1", Vector2(900, 500), 90)
	spawn_quadrato("Pezzo_Q1", Vector2(500, 650))
	
	spawn_triangolo("Pezzo_T3", Vector2(200, 250), 180)
	spawn_rettangolo("Pezzo_R2", Vector2(800, 250), 90)
	spawn_trapezio("Pezzo_Trap1", Vector2(500, 100), 0)
	spawn_l_shape("Falso_L2", Vector2(300, 650), 180)
	spawn_quadrato("Falso_Q2", Vector2(750, 650))
	spawn_rettangolo("Pezzo_R3", Vector2(1000, 350), 270)
	
func spawn_quadrato(nome, pos):
	var p = preload("res://square.tscn").instantiate()
	p.name = nome
	p.position = pos
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

func spawn_trapezio(nome, pos, rot = 0.0):
	var pezzo = Area2D.new()
	pezzo.set_script(load("res://scripts/trapezoid.gd"))
	pezzo.name = nome
	pezzo.position = pos
	pezzo.rotation_degrees = rot
	pezzo.scale = Vector2(0.75, 0.75)
	pezzo.set_meta("forma", "trapezoid")
	add_child(pezzo)

func spawn_triangolo(nome, pos, rot = 0.0):
	var pezzo = Area2D.new()
	pezzo.set_script(load("res://scripts/triangle.gd"))
	pezzo.name = nome
	pezzo.position = pos
	pezzo.rotation_degrees = rot
	pezzo.scale = Vector2(0.75, 0.75)
	pezzo.set_meta("forma", "triangolo")
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