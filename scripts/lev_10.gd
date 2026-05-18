extends "res://scripts/base_level.gd"

func _ready():
	var sagoma = Polygon2D.new()
	sagoma.color = Color(0, 0, 0, 0.3)
	# Rettangolo solido 4x3
	sagoma.polygon = PackedVector2Array([
		Vector2(351, 99), Vector2(951, 99), 
		Vector2(951, 549), Vector2(351, 549)
	])
	add_child(sagoma)

	# Spawn dei pezzi
	spawn_l_shape("Pezzo_L1", Vector2(100, 200), Color.ORANGE, 90)
	spawn_l_shape("Pezzo_L2", Vector2(1050, 450), Color.DARK_ORANGE)
	spawn_rettangolo("Pezzo_Rect1", Vector2(500, 650), Color.DARK_TURQUOISE, 90)
	spawn_rettangolo("Pezzo_Rect2", Vector2(1000, 650), Color.TEAL, 90)
	spawn_quadrato("Pezzo_Q1", Vector2(150, 550), Color.CRIMSON)
	spawn_quadrato("Pezzo_Q2", Vector2(1050, 100), Color.MEDIUM_PURPLE)

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

func spawn_l_shape(nome, pos, colore, rot = 0.0):
	var pezzo = Area2D.new()
	pezzo.set_script(load("res://scripts/l_shape.gd"))
	pezzo.name = nome
	pezzo.position = pos
	pezzo.modulate = colore
	pezzo.rotation_degrees = rot
	pezzo.scale = Vector2(0.75, 0.75)
	pezzo.set_meta("forma", "l_shape")
	add_child(pezzo)
