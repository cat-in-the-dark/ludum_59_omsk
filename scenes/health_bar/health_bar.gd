extends Node2D

signal update_health(amount)
signal reset

@onready var bar: TextureProgressBar = $TextureProgressBar

func _ready() -> void:
	update_health.connect(on_update_health)
	
func on_update_health(_value: float):
	var tween = create_tween()
