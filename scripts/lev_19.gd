# ============================================================================
# LEVEL 19 - FIND THE HIDDEN PIECES
# ============================================================================
# Difficulty: Expert
# Mechanics: two pieces disappear after 3 seconds.
# Challenge: Locate and reveal the invisible pieces.

extends "res://scripts/level_template.gd"

var invisible_pieces: Array = []
var revealed_pieces: Array = []
var disappear_timer: float = 3.0
var pieces_disappeared: bool = false
var timer_disabled: bool = false

func setup_level():
	piece_scale = 0.75
	tooltip_text = "Find a way"
	grid_step = 0.0
	grid_offset_x = 0.0
	grid_offset_y = 0.0
	
	create_sagoma(PackedVector2Array([
		Vector2(400, 200), Vector2(850, 200),
		Vector2(850, 500), Vector2(400, 500)
	]))
	
	var p1 = spawn_rettangolo("Pezzo_R1", Vector2(150, 200), 0)
	var p2 = spawn_rettangolo("Pezzo_R2", Vector2(150, 480), 90)
	var p3 = spawn_quadrato("Pezzo_Q1", Vector2(1100, 200))
	var p4 = spawn_quadrato("Pezzo_Q2", Vector2(1100, 480))
	
	p2.set_meta("invisible_piece", true)
	p2.set_meta("revealed", false)
	p3.set_meta("invisible_piece", true)
	p3.set_meta("revealed", false)
	
	invisible_pieces = [p1, p2, p3]

func _ready():
	super._ready()
	await get_tree().process_frame
	
	for pezzo in invisible_pieces:
		if is_instance_valid(pezzo):
			pezzo.input_pickable = true
			pezzo.input_event.connect(func(viewport, event, shape_idx):
				_on_piece_right_clicked(pezzo, event)
			)
	
	if has_node("UI/BtnLevel"):
		var btn = $UI/BtnLevel
		btn.mouse_filter = Control.MOUSE_FILTER_STOP
		btn.pressed.connect(_on_level_button_pressed)

func _process(delta):
	super._process(delta)

	if timer_disabled:
		return

	# Se tutti i pezzi sono rivelati, non far scomparire nulla
	if revealed_pieces.size() == invisible_pieces.size():
		pieces_disappeared = false
		disappear_timer = -1.0
		return

	if not pieces_disappeared and disappear_timer > 0:
		disappear_timer -= delta
		if disappear_timer <= 0:
			_hide_invisible_pieces()

func _on_piece_right_clicked(pezzo: Node2D, event: InputEvent):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
		if pezzo.get_meta("invisible_piece") and not pezzo.get_meta("revealed"):
			_reveal_piece(pezzo)

func _hide_invisible_pieces():
	pieces_disappeared = true
	for pezzo in invisible_pieces:
		if is_instance_valid(pezzo) and not pezzo.get_meta("revealed"):
			pezzo.visible = false

func _reveal_piece(pezzo: Node2D):
	if is_instance_valid(pezzo):
		pezzo.visible = true
		pezzo.set_meta("revealed", true)
		revealed_pieces.append(pezzo)

func _on_level_button_pressed():
	timer_disabled = true
	pieces_disappeared = false
	revealed_pieces.clear()
	
	for pezzo in invisible_pieces:
		if is_instance_valid(pezzo):
			pezzo.visible = true
			pezzo.set_meta("revealed", true)
			revealed_pieces.append(pezzo)

func controlla_vittoria() -> bool:
	for pezzo in invisible_pieces:
		if not pezzo.get_meta("revealed"):
			return false
	
	return super.controlla_vittoria()
