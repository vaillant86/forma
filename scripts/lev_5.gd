extends "res://scripts/base_level.gd"

func _ready():
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

	spawn_quadrato("Pezzo_Rosso", Vector2(150, 500))
	spawn_rettangolo("Pezzo_Rect", Vector2(900, 200))
	spawn_l_shape("Pezzo_L", Vector2(950, 450), 90)

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
	pezzo.global_rotation_degrees = rot
	pezzo.scale = Vector2(0.75, 0.75)
	pezzo.set_meta("forma", "l_shape")
	add_child(pezzo)
