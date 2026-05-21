extends Control

func _ready():
	# 1. Se siamo appena entrati nel gioco da zero, allineiamo current_level al massimo sbloccato
	if SaveManager.current_level == 1 and SaveManager.save_data["livello_sbloccato"] > 1:
		SaveManager.current_level = SaveManager.save_data["livello_sbloccato"]

	# 2. Mostriamo sul pulsante il livello CORRENTE da dove l'utente deve davvero riprendere
	if SaveManager.save_data.has("livello_sbloccato") and SaveManager.save_data["livello_sbloccato"] > 1:
		$VBoxContainer/BtnContinua.disabled = false
		$VBoxContainer/BtnContinua.text = "CONTINUE (Level " + str(SaveManager.current_level) + ")"
	else:
		$VBoxContainer/BtnContinua.disabled = true
		$VBoxContainer/BtnContinua.text = "CONTINUE"

func _on_btn_nuova_partita_pressed():
	SaveManager.save_data["livello_sbloccato"] = 1
	SaveManager.current_level = 1 # Resetta anche il livello corrente!
	SaveManager.save_game()
	get_tree().change_scene_to_file("res://lev_1.tscn")

func _on_btn_continua_pressed():
	# La logica qui è già perfetta e pulita
	var path = "res://lev_" + str(SaveManager.current_level) + ".tscn"
	if ResourceLoader.exists(path):
		get_tree().change_scene_to_file(path)

func _on_btn_esci_pressed():
	get_tree().quit()

func _process(delta):
	if MusicManager.is_muted:
		$BtnAudio.text = "AUDIO: OFF"
	else:
		$BtnAudio.text = "AUDIO: ON"

func _on_btn_audio_pressed():
	MusicManager.toggle_mute()
