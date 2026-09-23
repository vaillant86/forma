extends Control

func _ready():
    _update_continue_button()
    _update_audio_button()
    _focus_first_button()

func _focus_first_button():
    var first_button = $CenterContainer/VBoxContainer/BtnNuovaPartita
    if is_instance_valid(first_button):
        first_button.grab_focus()

func _update_continue_button():
    if SaveManager.current_level == 1 and SaveManager.save_data.get("livello_sbloccato", 1) > 1:
        SaveManager.current_level = SaveManager.save_data["livello_sbloccato"]

    var continue_btn = $CenterContainer/VBoxContainer/BtnContinua
    if SaveManager.save_data.has("livello_sbloccato") and SaveManager.save_data["livello_sbloccato"] > 1:
        continue_btn.disabled = false
        continue_btn.text = "CONTINUE (Level " + str(SaveManager.current_level) + ")"
    else:
        continue_btn.disabled = true
        continue_btn.text = "CONTINUE"

func _update_audio_button():
    var audio_button = $MarginContainer/BtnAudio
    if MusicManager.is_muted:
        audio_button.text = "AUDIO: OFF"
    else:
        audio_button.text = "AUDIO: ON"

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

func _on_btn_audio_pressed():
    MusicManager.toggle_mute()
    _update_audio_button()
