extends "res://scripts/base_level.gd"

var audio_player: AudioStreamPlayer
var is_level_completed = false

func _ready():
	var sagoma = Polygon2D.new()
	sagoma.color = Color(0, 0, 0, 0.3)
	
	sagoma.polygon = PackedVector2Array([
		Vector2(500, 350),
		Vector2(350, 250),
		Vector2(300, 180),
		Vector2(350, 120),
		Vector2(450, 100),
		Vector2(550, 100),
		Vector2(650, 120),
		Vector2(700, 180),
		Vector2(650, 250),
	])
	add_child(sagoma)

	spawn_triangolo("Pezzo_T1", Vector2(150, 150), 0)
	spawn_triangolo("Pezzo_T2", Vector2(900, 150), 90)
	spawn_rettangolo("Pezzo_R1", Vector2(200, 450), 0)
	spawn_rettangolo("Pezzo_R2", Vector2(850, 450), 90)
	spawn_quadrato("Pezzo_Q1", Vector2(500, 550))
	
	spawn_l_shape("Falso_L1", Vector2(300, 650), 0)
	spawn_trapezio("Falso_Trap1", Vector2(700, 650), 180)
	spawn_triangolo("Falso_T3", Vector2(500, 750), 270)

	audio_player = get_node_or_null("../AudioStreamPlayer")
	if audio_player == null:
		for child in get_tree().root.get_children():
			if child.has_node("AudioStreamPlayer"):
				audio_player = child.get_node("AudioStreamPlayer")
				break
	
	var tip = Label.new()
	tip.text = "Listen to nothing"
	tip.add_theme_font_size_override("font_size", 20)
	tip.add_theme_color_override("font_color", Color(1.0, 0.84, 0, 0.6))
	tip.position = Vector2(500, 680)
	tip.align = TEXT_ALIGNMENT_CENTER
	add_child(tip)

func spawn_quadrato(nome, pos):
	var p = preload("res://square.tscn").instantiate()
	p.name = nome
	p.position = pos
	p.set_meta("forma", "quadrato")
	add_child(p)

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

func spawn_l_shape(nome, pos, rot = 0.0):
	var pezzo = Area2D.new()
	pezzo.set_script(load("res://scripts/l_shape.gd"))
	pezzo.name = nome
	pezzo.position = pos
	pezzo.rotation_degrees = rot
	pezzo.scale = Vector2(0.75, 0.75)
	pezzo.set_meta("forma", "l_shape")
	add_child(pezzo)

func check_victory():
	var all_pieces_aligned = _check_all_pieces_aligned()
	var audio_is_off = _is_audio_off()
	
	if all_pieces_aligned and audio_is_off:
		is_level_completed = true
		show_victory()
		return true
	elif all_pieces_aligned and not audio_is_off:
		var ui = get_node("UI")
		var label = ui.get_node_or_null("MessageLabel")
		if label == null:
			label = Label.new()
			label.name = "MessageLabel"
			label.add_theme_font_size_override("font_size", 24)
			label.add_theme_color_override("font_color", Color(1, 0.2, 0.2, 0.8))
			label.position = Vector2(500, 300)
			label.align = TEXT_ALIGNMENT_CENTER
			ui.add_child(label)
		label.text = "The shape is perfect, but sound corrupts the answer"
		await get_tree().create_timer(3.0).timeout
		label.queue_free()
	
	return false

func _check_all_pieces_aligned() -> bool:
	if has_method("_original_check_pieces"):
		return _original_check_pieces()
	return true

func _is_audio_off() -> bool:
	if audio_player == null:
		return false
	
	if audio_player.stream_paused:
		return true
	
	if audio_player.bus == "Master":
		var master_bus = AudioServer.get_bus_index("Master")
		if AudioServer.is_bus_mute(master_bus):
			return true
	
	if audio_player.volume_db < -80:
		return true
	
	return false