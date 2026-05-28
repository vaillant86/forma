# ============================================================================
# LEVEL 17 - CAST THE PERFECT SHADOW
# ============================================================================
# Difficulty: Expert
# Mechanics: Moving lamp projects shadow of piece onto sagoma.
# Challenge: Position lamp and piece to make shadow match target outline.

extends "res://scripts/level_template.gd"

var lamp: Node2D
var piece_main: Node2D
var block_object: Vector2
var silhouette_node: Polygon2D

var correct_lamp_pos: Vector2
var original_silhouette_y: float
var original_sagoma_position: Vector2

var lamp_is_snapped: bool = false
var piece_is_snapped: bool = false

func setup_level():
	piece_scale = 1.0
	tooltip_text = "Cast the perfect shadow"
	
	var punti_sagoma = PackedVector2Array([
		Vector2(583, 284), Vector2(783, 284),
		Vector2(783, 484), Vector2(583, 484)
	])
	create_sagoma(punti_sagoma)
	
	spawn_quadrato("Pezzo_Main", Vector2(250, 550))
	spawn_triangolo("Pezzo_Lampadina", Vector2(900, 300))

func _ready():
	super._ready()
	await get_tree().process_frame
	await get_tree().process_frame
	
	grid_step = 0.0
	
	lamp = get_node_or_null("Pezzo_Lampadina")
	piece_main = get_node_or_null("Pezzo_Main")
	
	if lamp:
		lamp.modulate = Color(1.0, 1.0, 0.4)
	
	silhouette_node = get_node_or_null("Sagoma")
	original_sagoma_position = silhouette_node.position
	
	if silhouette_node:
		var local_center = (silhouette_node.polygon[0] + silhouette_node.polygon[2]) / 2
		block_object = silhouette_node.to_global(local_center)
		original_silhouette_y = block_object.y
		correct_lamp_pos = block_object - Vector2(0, 234)

func calcola_griglia_automatica():
	super.calcola_griglia_automatica()
	grid_step = 0.0

func _process(_delta):
	super._process(_delta)
	if not lamp or not silhouette_node:
		return
	
	if "trascinamento" in lamp and lamp.trascinamento:
		lamp_is_snapped = false
	else:
		if lamp.global_position.distance_to(correct_lamp_pos) < 35.0:
			lamp.global_position = correct_lamp_pos
			lamp_is_snapped = true
		else:
			lamp_is_snapped = false
	
	if lamp_is_snapped:
		silhouette_node.scale = Vector2(1.0, 1.0)
		silhouette_node.position = original_sagoma_position
	else:
		var distance_y = max(20.0, block_object.y - lamp.global_position.y)
		var scale_factor = clamp(234.0 / distance_y, 0.4, 2.2)
		
		silhouette_node.scale = Vector2(scale_factor, scale_factor)
		
		var shift_x = (block_object.x - lamp.global_position.x) * (scale_factor - 1.0) * 0.5
		silhouette_node.position = Vector2(
			block_object.x * (1.0 - scale_factor) + shift_x,
			block_object.y * (1.0 - scale_factor)
		)
	
	if piece_main:
		if "trascinamento" in piece_main and piece_main.trascinamento:
			piece_is_snapped = false
		else:
			if piece_main.global_position.distance_to(block_object) < 45.0:
				piece_main.global_position = block_object
				piece_is_snapped = true
			else:
				piece_is_snapped = false
			
func controlla_vittoria() -> bool:
	if lamp and "trascinamento" in lamp and lamp.trascinamento:
		return false
	if piece_main and "trascinamento" in piece_main and piece_main.trascinamento:
		return false
	
	if lamp_is_snapped and piece_is_snapped:
		return true
	
	return false
