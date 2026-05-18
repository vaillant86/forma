extends Area2D

static var pezzo_attivo = null

var trascinamento = false
var scarto_mouse = Vector2.ZERO
var raggio_pezzo = 50

func _ready():
	modulate = Color(0.30, 0.30, 0.30) # GRIGIO SCURO

func _setup_shape(vertici: PackedVector2Array) -> void:
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

func _process(_delta):
	if trascinamento:
		global_position = get_global_mouse_position() + scarto_mouse
		var limiti = get_viewport().get_visible_rect().size
		global_position.x = clamp(global_position.x, raggio_pezzo, limiti.x - raggio_pezzo)
		global_position.y = clamp(global_position.y, raggio_pezzo, limiti.y - raggio_pezzo)

func applica_calamita():
	var livello = get_parent()

	var step = 75.0
	var off_x = 51.0 
	var off_y = 24.0 

	if "grid_step" in livello:
		step = livello.grid_step
		off_x = livello.grid_offset_x
		off_y = livello.grid_offset_y
	
	var target_x = round((global_position.x - off_x) / step) * step + off_x
	var target_y = round((global_position.y - off_y) / step) * step + off_y
	
	var tween = create_tween()
	tween.tween_property(self, "global_position", Vector2(target_x, target_y), 0.1).set_trans(Tween.TRANS_SINE)
