extends "res://scripts/square.gd"

func _ready():
	super()
	_setup_shape(PackedVector2Array([
		Vector2(-100, 100),
		Vector2(300, 100),
		Vector2(300, -100),
		Vector2(100, -100),
		Vector2(100, -300),
		Vector2(-100, -300)
	]))
