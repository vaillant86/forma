extends "res://scripts/square.gd"

func _ready():
	# Forma a L: braccio verticale che va verso l'alto, braccio orizzontale verso destra
	var vertici = PackedVector2Array([
		Vector2(-100, 100),   # Angolo in basso a sinistra (origine)
		Vector2(300, 100),    # Punta estrema in basso a destra
		Vector2(300, -100),   # Punta alta del braccio destro
		Vector2(100, -100),   # Angolo interno
		Vector2(100, -300),   # Punta alta del braccio superiore
		Vector2(-100, -300)   # Punta sinistra del braccio superiore
	])
	
	var poly = Polygon2D.new()
	poly.polygon = vertici
	poly.color = Color.WHITE 
	add_child(poly)
	
	var collision = CollisionPolygon2D.new()
	collision.polygon = vertici
	add_child(collision)

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		
		# TASTO SINISTRO: Prendi e trascina
		if event.button_index == MOUSE_BUTTON_LEFT and pezzo_attivo == null:
			pezzo_attivo = self
			trascinamento = true
			scarto_mouse = global_position - get_global_mouse_position()
			z_index = 10
			get_viewport().set_input_as_handled()
			
		# TASTO DESTRO: Ruota di 90° a destra
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			# Ruota il pezzo di 90 gradi mantenendo l'angolo tra 0 e 360
			rotation_degrees = wrapf(rotation_degrees + 90.0, 0.0, 360.0)
			
			# Ricalcola la presa se stiamo ruotando il pezzo a mezz'aria
			if trascinamento:
				scarto_mouse = global_position - get_global_mouse_position()
				
			get_viewport().set_input_as_handled()

# Questa funzione gestisce il rilascio del tasto del mouse
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if not event.pressed and trascinamento:
			trascinamento = false
			z_index = 0
			applica_calamita() # Fa scattare l'aggancio alla griglia!
			pezzo_attivo = null

func applica_calamita():
	var livello = get_parent()
	
	# Fallback nel caso il pezzo sia fuori dal livello
	var step = 75.0
	var off_x = 51.0 
	var off_y = 24.0 
	
	# Legge dinamicamente la griglia impostata dal livello!
	if "grid_step" in livello:
		step = livello.grid_step
		off_x = livello.grid_offset_x
		off_y = livello.grid_offset_y
	
	var target_x = round((global_position.x - off_x) / step) * step + off_x
	var target_y = round((global_position.y - off_y) / step) * step + off_y
	
	var tween = create_tween()
	tween.tween_property(self, "global_position", Vector2(target_x, target_y), 0.1).set_trans(Tween.TRANS_SINE)
