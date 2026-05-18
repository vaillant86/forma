extends Control

func _ready():
	if SaveManager.save_data.has("livello_sbloccato") and SaveManager.save_data["livello_sbloccato"] > 1:
		var livello_intero = int(SaveManager.save_data["livello_sbloccato"])
		$VBoxContainer/BtnContinua.disabled = false
		$VBoxContainer/BtnContinua.text = "CONTINUE (Level " + str(livello_intero) + ")"
	else:
		$VBoxContainer/BtnContinua.disabled = true
		$VBoxContainer/BtnContinua.text = "CONTINUE"

func _on_btn_nuova_partita_pressed():
	SaveManager.save_data["livello_sbloccato"] = 1
	SaveManager.save_game()
	get_tree().change_scene_to_file("res://lev_1.tscn")

func _on_btn_continua_pressed():
	var livello = int(SaveManager.save_data["livello_sbloccato"])
	var percorso_livello = "res://lev_" + str(livello) + ".tscn"
	
	if ResourceLoader.exists(percorso_livello):
		get_tree().change_scene_to_file(percorso_livello)
	else:
		get_tree().change_scene_to_file("res://lev_1.tscn")

func _on_btn_esci_pressed():
	get_tree().quit()

func _process(delta):
	if MusicManager.is_muted:
		$BtnAudio.text = "AUDIO: OFF"
	else:
		$BtnAudio.text = "AUDIO: ON"

func _on_btn_audio_pressed():
	MusicManager.toggle_mute()
