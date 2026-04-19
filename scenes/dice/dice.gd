extends Node2D

class_name Dice

@onready var vis_number: Sprite2D = $number
@onready var hover: Sprite2D = $number/hover
var selected: bool = false

# lazy hack i don't have time to extract it
var holder: Dices

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
	if value == 0:
		return
	hover.visible = true

func _on_area_2d_mouse_exited() -> void:
	hover.visible = false

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if value == 0:
		return
	if event.is_action_pressed("click") and event.is_pressed():
		if not selected:
			if holder.can_select():
				selected = true
				self.vis_number.scale.x = 1.4
				self.vis_number.scale.y = 1.4
			else:
				# TODO: sfx
				print("too many selected")
		else:
			selected = false
			self.vis_number.scale.x = 1
			self.vis_number.scale.y = 1
