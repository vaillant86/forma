extends "res://scripts/square.gd"

func _ready():
	super() # Richiama il grigio scuro da square.gd

	var vertici = PackedVector2Array([
		Vector2(0, -50),   # Punta
		Vector2(100, 50),  # Angolo basso destra
		Vector2(-100, 50)  # Angolo basso sinistra
	])
	
	var poly = Polygon2D.new()
	poly.polygon = vertici
	add_child(poly)
	
	var collision = CollisionPolygon2D.new()
	collision.polygon = vertici
	add_child(collision)

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		
		if event.button_index == MOUSE_BUTTON_LEFT and pezzo_attivo == null:
			pezzo_attivo = self
			trascinamento = true
			scarto_mouse = global_position - get_global_mouse_position()
			z_index = 10
			get_viewport().set_input_as_handled()
			
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			rotation_degrees += 90.0
			rotation_degrees = round(rotation_degrees / 90.0) * 90.0
			
			if trascinamento:
				scarto_mouse = global_position - get_global_mouse_position()
				
			get_viewport().set_input_as_handled()

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if not event.pressed and trascinamento:
			trascinamento = false
			z_index = 0
			applica_calamita() 
			pezzo_attivo = null
