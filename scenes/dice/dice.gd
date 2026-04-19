extends Node2D

class_name Dice

@onready var vis_number: Sprite2D = $number
@onready var hover: Sprite2D = $number/hover
var selected: bool = false

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

func _ready() -> void:
	vis_number.texture = load(vis_numbers[value])

func roll():
	value = randi_range(1, 6)
	vis_number.texture = load(vis_numbers[value])

func _on_area_2d_mouse_entered() -> void:
	hover.visible = true

func _on_area_2d_mouse_exited() -> void:
	hover.visible = false

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		selected = not selected
		if selected:
			self.vis_number.scale.x = 1.4
			self.vis_number.scale.y = 1.4
		else:
			self.vis_number.scale.x = 1
			self.vis_number.scale.y = 1
