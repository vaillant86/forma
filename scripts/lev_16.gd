extends "res://scripts/level_template.gd"

var center_x: float = 683.0
var piece_left: Node2D
var piece_right: Node2D
var left_target: Vector2 = Vector2(433, 384)
var right_target: Vector2 = Vector2(933, 384)

func setup_level():
	piece_scale = 1.0
	tooltip_text = "Reflections walk different paths"
	
	var s1 = Polygon2D.new()
	s1.color = Color(0, 0, 0, 0.3)
	s1.polygon = PackedVector2Array([
		Vector2(333, 284), Vector2(533, 284),
		Vector2(533, 484), Vector2(333, 484)
	])
	s1.name = "Sagoma_Sinistra"
	add_child(s1)

	var s2 = Polygon2D.new()
	s2.color = Color(0, 0, 0, 0.3)
	s2.polygon = PackedVector2Array([
		Vector2(833, 284), Vector2(1033, 284),
		Vector2(1033, 484), Vector2(833, 484)
	])
	s2.name = "Sagoma_Destra"
	add_child(s2)
	
	left_target = Vector2(433, 384)
	right_target = Vector2(833, 384)
	
	spawn_quadrato("Pezzo_Main", Vector2(200, 150))
	spawn_quadrato("Pezzo_Extra", Vector2(1166, 150))

func center_sagoma():
	pass
	
func _ready():
	super._ready()
	await get_tree().process_frame
	piece_left = get_node_or_null("Pezzo_Main")
	piece_right = get_node_or_null("Pezzo_Extra")

func _process(_delta):
	if piece_left and piece_right:
		if "trascinamento" in piece_left and piece_left.trascinamento:
			var dist = center_x - piece_left.position.x
			piece_right.position.x = clamp(center_x + dist, center_x + 50, 1316)
			piece_right.position.y = piece_left.position.y
		elif "trascinamento" in piece_right and piece_right.trascinamento:
			var dist = piece_right.position.x - center_x
			piece_left.position.x = clamp(center_x - dist, 50, center_x - 50)
			piece_left.position.y = piece_right.position.y

func controlla_vittoria() -> bool:
	if not (piece_left and piece_right):
		return false
	if ("trascinamento" in piece_left and piece_left.trascinamento) or \
	   ("trascinamento" in piece_right and piece_right.trascinamento):
		return false
	
	var left_ok = piece_left.position.distance_to(left_target) < 30.0
	var right_ok = piece_right.position.distance_to(right_target) < 30.0
	
	if left_ok and right_ok:
		piece_left.position = left_target
		piece_right.position = right_target
		return true
	
	return false
