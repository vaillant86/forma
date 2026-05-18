extends "res://scripts/square.gd"

func _ready():
    super()
    _setup_shape(PackedVector2Array([
        Vector2(0, -50),
        Vector2(100, 50),
        Vector2(-100, 50)
    ]))
