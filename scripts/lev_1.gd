extends "res://scripts/base_level.gd"

func _ready():
	grid_step = 100.0
	grid_offset_x = 0.0
	grid_offset_y = 0.0

	var sagoma = Polygon2D.new()
	sagoma.color = Color(0, 0, 0, 0.3)
	sagoma.polygon = PackedVector2Array([
		Vector2(400, 200), Vector2(800, 200), Vector2(800, 400),
		Vector2(600, 400), Vector2(600, 600), Vector2(400, 600)
	])
	add_child(sagoma)

	spawn_quadrato("Pezzo_Rosso", Vector2(200, 200), Color(0.85, 0.2, 0.2))
	spawn_quadrato("Pezzo_Verde", Vector2(1000, 200), Color(0.2, 0.7, 0.3))
	spawn_quadrato("Pezzo_Blu", Vector2(200, 500), Color(0.2, 0.4, 0.8))

func spawn_quadrato(nome, pos, colore):
	var p = preload("res://square.tscn").instantiate()
	p.name = nome
	p.position = pos
	p.modulate = colore
	add_child(p)
