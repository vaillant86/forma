extends "res://scripts/base_level.gd"

func _ready():
	# Sagoma: Un diamante / cristallo
	var sagoma = Polygon2D.new()
	sagoma.color = Color(0, 0, 0, 0.3)
	sagoma.polygon = PackedVector2Array([
		Vector2(501, 174), Vector2(576, 249), Vector2(651, 174), 
		Vector2(726, 249), Vector2(726, 549), Vector2(651, 624), 
		Vector2(576, 549), Vector2(501, 624), Vector2(426, 549), 
		Vector2(426, 249)
	])
	add_child(sagoma)

	# Spawn dei pezzi
	spawn_l_shape("Pezzo_L", Vector2(150, 350), Color.ORANGE)
	spawn_quadrato("Pezzo_Q", Vector2(1000, 550), Color.CRIMSON)
	spawn_triangolo("Pezzo_T1", Vector2(150, 550), Color.DARK_TURQUOISE, 270)
	spawn_triangolo("Pezzo_T2", Vector2(850, 100), Color.AQUA, 90)
	spawn_triangolo("Pezzo_T3", Vector2(1000, 150), Color.HOT_PINK, 0)
	spawn_triangolo("Pezzo_T4", Vector2(1100, 350), Color.VIOLET, 180)

# --- FUNZIONI DI SPAWN ---
func spawn_quadrato(nome, pos, colore):
	var p = preload("res://square.tscn").instantiate()
	p.name = nome
	p.position = pos
	p.modulate = colore
	p.scale = Vector2(0.75, 0.75)
	p.set_meta("forma", "quadrato")
	add_child(p)

func spawn_l_shape(nome, pos, colore):
	var pezzo = Area2D.new()
	pezzo.set_script(load("res://scripts/l_shape.gd"))
	pezzo.name = nome
	pezzo.position = pos
	pezzo.modulate = colore
	pezzo.scale = Vector2(0.75, 0.75)
	pezzo.set_meta("forma", "l_shape")
	add_child(pezzo)

func spawn_triangolo(nome, pos, colore, rot):
	var tr = Area2D.new()
	tr.set_script(load("res://scripts/triangle.gd"))
	tr.name = nome
	tr.position = pos
	tr.modulate = colore
	tr.rotation_degrees = rot
	tr.scale = Vector2(0.75, 0.75)
	tr.set_meta("forma", "triangolo")
	add_child(tr)
