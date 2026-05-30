extends Control

const MAIN_MENU_PATH = "res://main_menu.tscn"
# Inserisci qui la durata reale del tuo video (3.0 secondi o quella effettiva)
const VIDEO_DURATION: float = 3.0

@onready var video_player: VideoStreamPlayer = $VideoStreamPlayer
var _scene_on_change: bool = false

func _ready() -> void:
	if video_player.stream == null:
		_change_to_menu()
		return

	if not video_player.finished.is_connected(_on_video_finished):
		video_player.finished.connect(_on_video_finished)

	# Usa la costante VIDEO_DURATION definita sopra invece di chiamare get_length()
	var timer = get_tree().create_timer(VIDEO_DURATION + 0.5)
	timer.timeout.connect(_on_video_finished)

	video_player.play()
	
func _input(event: InputEvent) -> void:
	if _scene_on_change:
		return
	if event.is_action_pressed("ui_accept"):
		_change_to_menu()
	elif event is InputEventMouseButton and event.pressed:
		_change_to_menu()

func _on_video_finished() -> void:
	if not _scene_on_change:
		_change_to_menu()

func _change_to_menu() -> void:
	_scene_on_change = true

	if is_instance_valid(video_player):
		video_player.stop()
		video_player.visible = false

	call_deferred("_deferred_change_scene")

func _deferred_change_scene() -> void:
	if is_inside_tree():
		var error = get_tree().change_scene_to_file(MAIN_MENU_PATH)
