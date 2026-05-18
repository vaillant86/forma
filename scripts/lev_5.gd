extends "res://scripts/base_level.gd"

func _ready():
	# 1. Sagoma: "Scala" a 6 blocchi, ridotta al 75% (blocchi da 150x150 px)
	var sagoma = Polygon2D.new()
	sagoma.color = Color(0, 0, 0, 0.3)
	sagoma.polygon = PackedVector2Array([
		Vector2(351, 549), # Basso-Sinistra
		Vector2(801, 549), # Basso-Destra
		Vector2(801, 399), # Scalino destro (alzata)
		Vector2(651, 399), # Scalino destro (pedata)
		Vector2(651, 249), # Scalino centrale (alzata)
		Vector2(501, 249), # Scalino centrale (pedata)
		Vector2(501, 99),  # Scalino alto (alzata)
		Vector2(351, 99)   # Scalino alto (pedata / alto-sinistra)
	])
	add_child(sagoma)

	# 2. Pezzi generati (scala 0.75)
	spawn_quadrato("Pezzo_Rosso", Vector2(150, 500), Color.CRIMSON)
	spawn_rettangolo("Pezzo_Rect", Vector2(900, 200), Color.DARK_TURQUOISE)
	spawn_l_shape("Pezzo_L", Vector2(950, 450), Color.ORANGE, 90)

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
	pezzo.global_rotation_degrees = rot
	pezzo.scale = Vector2(0.75, 0.75)
	pezzo.set_meta("forma", "l_shape")
	add_child(pezzo)
