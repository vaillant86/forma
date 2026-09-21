extends Control

func _ready():
	if SaveManager.current_level == 1 and SaveManager.save_data["livello_sbloccato"] > 1:
		SaveManager.current_level = SaveManager.save_data["livello_sbloccato"]

	if SaveManager.save_data.has("livello_sbloccato") and SaveManager.save_data["livello_sbloccato"] > 1:
		$VBoxContainer/BtnContinua.disabled = false
		$VBoxContainer/BtnContinua.text = "CONTINUE (Level " + str(SaveManager.current_level) + ")"
	else:
		$VBoxContainer/BtnContinua.disabled = true
		$VBoxContainer/BtnContinua.text = "CONTINUE"

func _on_btn_nuova_partita_pressed():
	SaveManager.save_data["livello_sbloccato"] = 1
	SaveManager.current_level = 1
	SaveManager.save_game()
	get_tree().change_scene_to_file("res://levels/lev_01.tscn")

func _on_btn_continua_pressed():
	var level_str = "%02d" % SaveManager.current_level
	var path = "res://levels/lev_" + level_str + ".tscn"
	if ResourceLoader.exists(path):
		get_tree().change_scene_to_file(path)
	else:
		push_error("Impossibile trovare la scena al percorso: " + path)

func _on_btn_esci_pressed():
	get_tree().quit()

func _process(delta):
	if MusicManager.is_muted:
		$BtnAudio.text = "AUDIO: OFF"
	else:
		$BtnAudio.text = "AUDIO: ON"

func _on_btn_audio_pressed():
	MusicManager.toggle_mute()
