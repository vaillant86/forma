extends "res://scripts/square.gd"

func _ready():
	super()
	_setup_shape(PackedVector2Array([
		Vector2(-100, -200),
		Vector2(100, -200),
		Vector2(100, 200),
		Vector2(-100, 200)
	]))
