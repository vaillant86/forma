extends "res://scripts/base_level.gd"

# ============================================================================
# LEVEL CONFIGURATION - Override in each level script
# ============================================================================

## Grid configuration (auto-calculated if left at defaults)
var grid_config = {
	"grid_step": 0.0,  # 0 = auto-calculate from first piece
	"grid_offset_x": 0.0,
	"grid_offset_y": 0.0
}

## Piece scale (normalized for all levels)
var piece_scale: float = 0.75

## Tooltip message (optional)
var tooltip_text: String = ""

## Sagoma position offset (will be calculated to center the shape)
var sagoma_offset: Vector2 = Vector2.ZERO

# ============================================================================
# OVERRIDE THIS FUNCTION IN EACH LEVEL
# ============================================================================

func setup_level():
	"""
	Override this function to set up your level's sagoma and spawn pieces.
	Example:
		func setup_level():
			create_sagoma([Vector2(400, 200), Vector2(800, 200), ...])
			spawn_quadrato("Pezzo_Rosso", Vector2(200, 200))
			spawn_triangolo("Pezzo_T1", Vector2(850, 150), 90)
	"""
	push_error("setup_level() not implemented in ", name)

# ============================================================================
# READY & INITIALIZATION
# ============================================================================

func _ready():
	# Apply grid configuration
	if grid_config["grid_step"] > 0:
		grid_step = grid_config["grid_step"]
		grid_offset_x = grid_config["grid_offset_x"]
		grid_offset_y = grid_config["grid_offset_y"]
	
	# Call level-specific setup
	setup_level()
	
	# Center the sagoma (must be called after setup_level)
	center_sagoma()
	
	# Add tooltip if provided
	if tooltip_text != "":
		add_tooltip(tooltip_text)

# ============================================================================
# SAGOMA CREATION HELPER
# ============================================================================

func create_sagoma(points: PackedVector2Array):
	"""Create and add a sagoma (outline shape) to the level."""
	var sagoma = Polygon2D.new()
	sagoma.color = Color(0, 0, 0, 0.3)
	sagoma.polygon = points
	sagoma.name = "Sagoma"  # Give it a name for easy retrieval
	add_child(sagoma)
	return sagoma

func center_sagoma():
	var sagoma = get_node_or_null("Sagoma")
	if sagoma == null:
		return
	
	var viewport_center = Vector2(683, 384)
	
	# Calculate centroid of the sagoma polygon
	var centroid = _calculate_polygon_centroid(sagoma.polygon)
	
	# Calculate offset to center the sagoma
	var offset = viewport_center - centroid
	
	# Apply offset to sagoma
	sagoma.position += offset
	sagoma_offset = offset
	
	# Also offset all pieces by the same amount
	for child in get_children():
		if child.name.begins_with("Pezzo_") or child.name.begins_with("Falso_"):
			child.position += offset

func _calculate_polygon_centroid(polygon: PackedVector2Array) -> Vector2:
	"""Calculate the centroid (center point) of a polygon."""
	if polygon.is_empty():
		return Vector2.ZERO
	
	var sum = Vector2.ZERO
	for point in polygon:
		sum += point
	
	return sum / polygon.size()

# ============================================================================
# SPAWN FUNCTIONS - STANDARDIZED
# ============================================================================

func spawn_quadrato(nome: String, pos: Vector2, rot: float = 0.0):
	"""Spawn a square piece."""
	var p = preload("res://square.tscn").instantiate()
	p.name = nome
	p.position = pos
	p.rotation_degrees = rot
	p.scale = Vector2(piece_scale, piece_scale)
	p.set_meta("forma", "quadrato")
	add_child(p)
	return p

func spawn_triangolo(nome: String, pos: Vector2, rot: float = 0.0):
	"""Spawn a triangle piece."""
	var pezzo = Area2D.new()
	pezzo.set_script(load("res://scripts/triangle.gd"))
	pezzo.name = nome
	pezzo.position = pos
	pezzo.rotation_degrees = rot
	pezzo.scale = Vector2(piece_scale, piece_scale)
	pezzo.set_meta("forma", "triangolo")
	add_child(pezzo)
	return pezzo

func spawn_rettangolo(nome: String, pos: Vector2, rot: float = 0.0):
	"""Spawn a rectangle piece."""
	var pezzo = Area2D.new()
	pezzo.set_script(load("res://scripts/rectangle.gd"))
	pezzo.name = nome
	pezzo.position = pos
	pezzo.rotation_degrees = rot
	pezzo.scale = Vector2(piece_scale, piece_scale)
	pezzo.set_meta("forma", "rettangolo")
	add_child(pezzo)
	return pezzo

func spawn_l_shape(nome: String, pos: Vector2, rot: float = 0.0):
	"""Spawn an L-shaped piece."""
	var pezzo = Area2D.new()
	pezzo.set_script(load("res://scripts/l_shape.gd"))
	pezzo.name = nome
	pezzo.position = pos
	pezzo.rotation_degrees = rot
	pezzo.scale = Vector2(piece_scale, piece_scale)
	pezzo.set_meta("forma", "l_shape")
	add_child(pezzo)
	return pezzo

func spawn_trapezoid(nome: String, pos: Vector2, rot: float = 0.0):
	"""Spawn a trapezoid piece."""
	var pezzo = Area2D.new()
	pezzo.set_script(load("res://scripts/trapezoid.gd"))
	pezzo.name = nome
	pezzo.position = pos
	pezzo.rotation_degrees = rot
	pezzo.scale = Vector2(piece_scale, piece_scale)
	pezzo.set_meta("forma", "trapezoid")
	add_child(pezzo)
	return pezzo

# ============================================================================
# UI HELPERS
# ============================================================================

func add_tooltip(text: String, position: Vector2 = Vector2.ZERO):
	"""Add a tooltip label to the level, aligned to the right with 20px margin."""
	var tip = Label.new()
	tip.text = text
	tip.add_theme_font_size_override("font_size", 22)
	tip.add_theme_color_override("font_color", Color(1.0, 1.0, 1.0, 0.6))

	add_child(tip)

	await get_tree().process_frame
	
	var right_margin = 20
	var label_width = tip.get_minimum_size().x
	var x_position = 1366 - label_width - right_margin
	
	var y_position = position.y if position.y != 0 else 710
	
	tip.position = Vector2(x_position, y_position)

# ============================================================================
# CUSTOM WIN CONDITIONS - Override in specific levels
# ============================================================================

func controlla_vittoria() -> bool:
	"""
	Override this to create custom win conditions.
	Always call super() first to check standard win condition.
	
	Example for level with audio requirement:
		func controlla_vittoria() -> bool:
			if not super.controlla_vittoria():
				return false
			var audio_muto = AudioServer.is_bus_mute(AudioServer.get_bus_index("Master"))
			return audio_muto
	"""
	return super.controlla_vittoria()

# ============================================================================
# UTILITY FUNCTIONS
# ============================================================================

func get_piece_by_name(nome: String):
	"""Get a piece by its name."""
	return get_node_or_null(nome)

func remove_piece(nome: String):
	"""Remove a piece by its name."""
	var pezzo = get_node_or_null(nome)
	if is_instance_valid(pezzo):
		pezzo.queue_free()
