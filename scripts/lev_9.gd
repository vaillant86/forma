extends "res://scripts/base_level.gd"

func _ready():
	# 1. Sagoma: "Il Podio"
	var sagoma = Polygon2D.new()
	sagoma.color = Color(0, 0, 0, 0.3)
	sagoma.polygon = PackedVector2Array([
		Vector2(351, 549), Vector2(801, 549), # Base
		Vector2(801, 249), Vector2(651, 249), # Gradino destro
		Vector2(651, 99),  Vector2(501, 99),  # Cima del podio (centro)
		Vector2(501, 249), Vector2(351, 249)  # Gradino sinistro
	])
	add_child(sagoma)

	# 2. Spawn dei pezzi (sparsi ai lati)
	spawn_l_shape("Pezzo_L", Vector2(150, 450), Color.ORANGE)
	spawn_rettangolo("Pezzo_Rect", Vector2(1000, 250), Color.DARK_TURQUOISE)
	spawn_quadrato("Pezzo_Q1", Vector2(150, 200), Color.CRIMSON)
	spawn_quadrato("Pezzo_Q2", Vector2(1000, 450), Color.MEDIUM_PURPLE)

# --- FUNZIONI DI SPAWN ---
func spawn_quadrato(nome, pos, colore):
	var p = preload("res://square.tscn").instantiate()
	p.name = nome
	p.position = pos
	p.modulate = colore
	p.scale = Vector2(0.75, 0.75)
	p.set_meta("forma", "quadrato")
	add_child(p)

func spawn_rettangolo(nome, pos, colore):
	var pezzo = Area2D.new()
	pezzo.set_script(load("res://scripts/rectangle.gd"))
	pezzo.name = nome
	pezzo.position = pos
	pezzo.modulate = colore
	pezzo.scale = Vector2(0.75, 0.75)
	pezzo.set_meta("forma", "rettangolo")
	add_child(pezzo)

func spawn_l_shape(nome, pos, colore):
	var pezzo = Area2D.new()
	pezzo.set_script(load("res://scripts/l_shape.gd"))
	pezzo.name = nome
	pezzo.position = pos
	pezzo.modulate = colore
	pezzo.scale = Vector2(0.75, 0.75)
	pezzo.set_meta("forma", "l_shape")
	add_child(pezzo)
