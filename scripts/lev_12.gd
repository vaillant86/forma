extends "res://scripts/level_template.gd"

func setup_level():
	piece_scale = 0.75
	tooltip_text = "Be quiet please..."
	
	create_sagoma(PackedVector2Array([
		Vector2(350, 200), Vector2(800, 200),
		Vector2(800, 500), Vector2(350, 500)
	]))
	
	spawn_l_shape("Pezzo_L", Vector2(100, 550))
	spawn_rettangolo("Pezzo_Rect", Vector2(1000, 200), 90)
	spawn_quadrato("Pezzo_Q2", Vector2(1100, 500))

func controlla_vittoria() -> bool:
	"""Win condition: pieces must be placed AND audio must be muted."""
	if not super.controlla_vittoria():
		return false
	var audio_muto = AudioServer.is_bus_mute(AudioServer.get_bus_index("Master"))
	return audio_muto
