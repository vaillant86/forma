extends Node

var player = AudioStreamPlayer.new()
var is_muted = false

func _ready():
	add_child(player)
	
	# Carica la traccia audio (assicurati che il nome coincida col tuo file)
	var track = load("res://music.ogg")
	if track:
		player.stream = track
		player.autoplay = true
		player.play()
	
	# Controlla se c'è una preferenza salvata
	if SaveManager.save_data.has("audio_muted"):
		is_muted = SaveManager.save_data["audio_muted"]
		_apply_mute()

func toggle_mute():
	is_muted = !is_muted
	_apply_mute()
	
	# Salviamo la preferenza nel file JSON!
	SaveManager.save_data["audio_muted"] = is_muted
	SaveManager.save_game()

func _apply_mute():
	# Modifica direttamente il volume del "Master" bus di Godot
	var master_bus = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_mute(master_bus, is_muted)
