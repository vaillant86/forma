extends "res://scripts/base_level.gd"

func _ready():
	var sagoma = Polygon2D.new()
	sagoma.color = Color(0, 0, 0, 0.3)
	
	sagoma.polygon = PackedVector2Array([
		Vector2(400, 200),   # Top Left
		Vector2(850, 200),   # Top Right
		Vector2(850, 500),   # Bottom Right
		Vector2(400, 500),   # Bottom Left
	])
	add_child(sagoma)

	# Pezzi iniziali in scena
	spawn_triangolo("Pezzo_T1", Vector2(100, 100), 0)
	spawn_triangolo("Pezzo_T2", Vector2(100, 250), 90)
	spawn_triangolo("Pezzo_T3", Vector2(100, 400), 180)
	spawn_triangolo("Pezzo_T4", Vector2(100, 550), 90)
	
	# I due rettangoli iniziali (R1 e R2)
	spawn_rettangolo("Pezzo_R1", Vector2(1000, 100), 90)
	spawn_rettangolo("Pezzo_R2", Vector2(500, 100), 90)
	
	spawn_quadrato("Pezzo_Q1", Vector2(1000, 400))
	
	# Creiamo il trapezio che si trasforma al click destro
	spawn_trapezio_trasformabile("Pezzo_TR1", Vector2(1000, 550))
	
	move_child(sagoma, 0)

func spawn_trapezio_trasformabile(nome, pos):
	var pezzo = Area2D.new()
	pezzo.set_script(load("res://scripts/trapezoid.gd"))
	pezzo.name = nome
	pezzo.position = pos
	pezzo.scale = Vector2(0.75, 0.75)
	pezzo.set_meta("forma", "trapezoid")
	add_child(pezzo)
	
	pezzo.input_pickable = true
	
	pezzo.input_event.connect(func(viewport, event, shape_idx):
		if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
			_attiva_trasformazione_reale(pezzo)
	)

func _attiva_trasformazione_reale(trapezio_nodo: Area2D):
	if is_instance_valid(trapezio_nodo):
		var pos_attuale = trapezio_nodo.position
		var rot_attuale = trapezio_nodo.rotation_degrees
		
		# Generiamo il rettangolo vero che prenderà il posto del trapezio
		spawn_rettangolo("Pezzo_R_Vero", pos_attuale, rot_attuale)
		
		# Eliminiamo il vecchio trapezio
		trapezio_nodo.queue_free()

# ==========================================
# FUNZIONE DI VITTORIA DEDICATA (OVERRIDE)
# ==========================================
func controlla_vittoria() -> bool:
	# 1. Se il giocatore sta ancora trascinando un pezzo, non è ancora il momento di vincere
	for n in get_children():
		if n.name.begins_with("Pezzo_") and "trascinamento" in n and n.trascinamento:
			return false

	# 2. Recuperiamo la lista dei pezzi "validi" attualmente in scena
	var t1 = get_node_or_null("Pezzo_T1")
	var t2 = get_node_or_null("Pezzo_T2")
	var t3 = get_node_or_null("Pezzo_T3")
	var t4 = get_node_or_null("Pezzo_T4")
	var r1 = get_node_or_null("Pezzo_R1")
	var r2 = get_node_or_null("Pezzo_R2")
	var q1 = get_node_or_null("Pezzo_Q1")
	var r_vero = get_node_or_null("Pezzo_R_Vero")

	# Se il rettangolo vero non è ancora nato (il giocatore non ha cliccato), la vittoria è impossibile
	if not r_vero:
		return false

	# Array con i nodi che DEVONO essere dentro la sagoma
	var pezzi_necessari = [t1, t2, t3, t4, r1, r2, q1, r_vero]

	# 3. Verifichiamo che ogni singolo pezzo sia posizionato correttamente
	for pezzo in pezzi_necessari:
		# Se per qualche motivo manca un nodo fondamentale, non si può vincere
		if not is_instance_valid(pezzo):
			return false
			
		# Controlliamo la posizione globale del pezzo: deve rientrare nel rettangolo della sagoma (400x200 a 850x500)
		# Teniamo un piccolo margine di tolleranza per il magnetismo
		var pos = pezzo.global_position
		if pos.x < 390 or pos.x > 860 or pos.y < 190 or pos.y > 510:
			return false

	# Se tutti i pezzi sono validi e si trovano dentro l'area della sagoma... VITTORIA!
	return true


# ==========================================
# FUNZIONI DI SPAWN STANDARD
# ==========================================
func spawn_quadrato(nome, pos):
	var p = preload("res://square.tscn").instantiate()
	p.name = nome
	p.position = pos
	p.scale = Vector2(0.75, 0.75)
	p.set_meta("forma", "quadrato")
	add_child(p)

func spawn_rettangolo(nome, pos, rot = 0.0) -> Area2D:
	var pezzo = Area2D.new()
	pezzo.set_script(load("res://scripts/rectangle.gd"))
	pezzo.name = nome
	pezzo.position = pos
	pezzo.rotation_degrees = rot
	pezzo.scale = Vector2(0.75, 0.75)
	pezzo.set_meta("forma", "rettangolo")
	add_child(pezzo)
	return pezzo

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
