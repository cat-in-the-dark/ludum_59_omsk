extends Node2D

class_name Dice

signal clicked(dice)
signal hovered(dice)
signal unhovered(dice)

@onready var vis_number: Sprite2D = $number
@onready var hover: Sprite2D = $number/hover
@export var textures: Array[Texture2D]

@export var value: int

func set_value(v: int):
	var was_hovered = hover.visible
	if was_hovered:
		unhovered.emit(value)

	value = v
	vis_number.texture = textures[v]
	
	if was_hovered:
		hovered.emit(value)

func _ready() -> void:
	set_value(0)

func roll():
	set_value(randi_range(1, 6))

func reset():
	set_value(0)

func _on_area_2d_mouse_entered() -> void:
	if value == 0:
		return
	hover.visible = true
	hovered.emit(value)

func _on_area_2d_mouse_exited() -> void:
	hover.visible = false
	unhovered.emit(value)

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if value == 0:
		return
	if event.is_action_pressed("click") and event.is_pressed():
		clicked.emit(value)
