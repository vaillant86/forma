extends "res://scripts/base_level.gd"

func _ready():
	grid_step = 100.0
	grid_offset_x = 0.0
	grid_offset_y = 0.0

	var sagoma = Polygon2D.new()
	sagoma.color = Color(0, 0, 0, 0.3)
	sagoma.polygon = PackedVector2Array([
		Vector2(376,  24), Vector2(776,  24), Vector2(776, 224),
		Vector2(576, 224), Vector2(776, 424),
		Vector2(776, 624), Vector2(376, 624), Vector2(376, 424),
		Vector2(576, 424), Vector2(376, 224),
	])
	add_child(sagoma)

	spawn_quadrato("Pezzo_Rosso", Vector2(150, 124), Color.INDIAN_RED)
	spawn_quadrato("Pezzo_Verde", Vector2(150, 524), Color.MEDIUM_SEA_GREEN)
	spawn_quadrato("Pezzo_Blu", Vector2(980, 124), Color.CORNFLOWER_BLUE)
	spawn_quadrato("Pezzo_Giallo", Vector2(980, 524), Color.GOLD)

	spawn_irregolare("Pezzo_IR", Vector2(980, 324), Color.CORAL)

func spawn_quadrato(nome, pos, colore):
	var p = preload("res://square.tscn").instantiate()
	p.name = nome
	p.position = pos
	p.modulate = colore
	add_child(p)

func spawn_irregolare(nome, pos, colore):
	var pezzo = Area2D.new()
	pezzo.set_script(load("res://scripts/trapezoid.gd"))
	pezzo.name = nome
	pezzo.position = pos
	pezzo.modulate = colore
	add_child(pezzo)
