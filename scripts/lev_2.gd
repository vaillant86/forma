extends "res://scripts/base_level.gd"

func _ready():
	grid_step = 100.0
	grid_offset_x = 0.0
	grid_offset_y = 0.0

	var sagoma = Polygon2D.new()
	sagoma.color = Color(0, 0, 0, 0.3)
	sagoma.polygon = PackedVector2Array([
		Vector2(300, 200), Vector2(900, 200), Vector2(900, 400),
		Vector2(700, 400), Vector2(700, 600), Vector2(500, 600),
		Vector2(500, 400), Vector2(300, 400)
	])
	add_child(sagoma)

	spawn_quadrato("Pezzo_Rosso", Vector2(150, 150))
	spawn_quadrato("Pezzo_Verde", Vector2(150, 500))
	spawn_quadrato("Pezzo_Blu", Vector2(1050, 150))
	spawn_quadrato("Pezzo_Giallo", Vector2(1050, 500))

func spawn_quadrato(nome, pos):
	var p = preload("res://square.tscn").instantiate()
	p.name = nome
	p.position = pos
	add_child(p)
