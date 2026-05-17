extends Node

var save_path = "user://forma_save.json"
var save_data = {
	"livello_sbloccato": 1,
	"audio_muted": false
}

func _ready():
	load_game()

func save_game():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_string(JSON.stringify(save_data))
	file.close()

func load_game():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		var parsed_result = JSON.parse_string(file.get_as_text())
		if parsed_result is Dictionary:
			save_data = parsed_result
