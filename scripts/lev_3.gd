extends "res://scripts/base_level.gd"

func _ready():
	grid_step = 100.0
	grid_offset_x = 0.0
	grid_offset_y = 0.0

	var sagoma = Polygon2D.new()
	sagoma.color = Color(0, 0, 0, 0.3)
	sagoma.polygon = PackedVector2Array([
		Vector2(400, 500), Vector2(600, 500), Vector2(600, 300), 
		Vector2(700, 300), Vector2(500, 100), Vector2(300, 300), 
		Vector2(400, 300)
	])
	add_child(sagoma)

	var sq = preload("res://square.tscn").instantiate()
	sq.name = "Pezzo_Base"
	sq.position = Vector2(150, 450)
	sq.modulate = Color.MEDIUM_SLATE_BLUE # Viola/Blu
	sq.set_meta("forma", "quadrato")      # Etichetta per il controllo vittoria
	add_child(sq)

	spawn_triangolo("Pezzo_T1", Vector2(850, 150), Color.CORAL, 0)      # Arancio acceso
	spawn_triangolo("Pezzo_T2", Vector2(1050, 150), Color.CHARTREUSE, 0) # Verde acido
	spawn_triangolo("Pezzo_T3", Vector2(950, 300), Color.AQUA, 180)    # Azzurro (Capovolto)
	spawn_triangolo("Pezzo_T4", Vector2(950, 500), Color.HOT_PINK, 0)   # Rosa acceso

func spawn_triangolo(nome, pos, colore, rot):
	var tr = Area2D.new()
	tr.set_script(load("res://scripts/triangle.gd"))
	tr.name = nome
	tr.position = pos
	tr.modulate = colore
	tr.rotation_degrees = rot
	tr.set_meta("forma", "triangolo")
	add_child(tr)
