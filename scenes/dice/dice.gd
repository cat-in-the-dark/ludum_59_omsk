extends Node2D

class_name Dice

signal clicked(dice)
signal hovered(dice)
signal unhovered(dice)

@onready var vis_number: Sprite2D = $number
@onready var hover: Sprite2D = $number/hover

var vis_numbers = [
	"res://resources/d6/d6-0.tres",
	"res://resources/d6/d6-1.tres",
	"res://resources/d6/d6-2.tres",
	"res://resources/d6/d6-3.tres",
	"res://resources/d6/d6-4.tres",
	"res://resources/d6/d6-5.tres",
	"res://resources/d6/d6-6.tres",
]

@export var value: int

func set_value(v: int):
	var was_hovered = hover.visible
	if was_hovered:
		unhovered.emit(value)

	value = v
	vis_number.texture = load(vis_numbers[v])
	
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
