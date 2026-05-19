extends "res://scripts/base_level.gd"

func _ready():
	var sagoma = Polygon2D.new()
	sagoma.color = Color(0, 0, 0, 0.3)
	
	sagoma.polygon = PackedVector2Array([
		Vector2(350, 150), # In alto a sinistra (Rettangolo)
		Vector2(500, 150), # In alto a destra (Rettangolo)
		Vector2(575, 225), # Punta del primo triangolo laterale
		Vector2(500, 300), # Inizio della diagonale
		Vector2(650, 300), # Top del trapezio
		Vector2(800, 450), # Estrema destra in basso
		Vector2(725, 525), # Punta del secondo triangolo (a testa in giù)
		Vector2(650, 450), # Inizio base inferiore
		Vector2(500, 450), # Angolo interno in basso
		Vector2(350, 450)  # In basso a sinistra (Rettangolo)
	])
	add_child(sagoma)

	spawn_rettangolo("Pezzo_Rect", Vector2(150, 400), 0)
	spawn_trapezio("Pezzo_Trap", Vector2(1000, 500), 180)
	spawn_triangolo("Pezzo_T1", Vector2(150, 150), 0)
	spawn_triangolo("Pezzo_T2", Vector2(900, 150), 90)
	spawn_triangolo("Pezzo_T3", Vector2(1000, 300), 90)
	spawn_triangolo("Pezzo_T4", Vector2(1100, 150), 180)
	
	spawn_triangolo("Falso_T5", Vector2(250, 100), 180)
	spawn_rettangolo("Falso_T6", Vector2(500, 600), 90)

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
