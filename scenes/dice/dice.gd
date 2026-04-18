extends Node2D

class_name Dice

@onready var vis_number: Sprite2D = $number

var vis_numbers = [
	"res://resources/d6/d6-1.tres",
	"res://resources/d6/d6-2.tres",
	"res://resources/d6/d6-3.tres",
	"res://resources/d6/d6-4.tres",
	"res://resources/d6/d6-5.tres",
	"res://resources/d6/d6-6.tres",
]

@export var value: int = 1

func _ready() -> void:
	vis_number.texture = load(vis_numbers[value-1])

func roll():
	value = randi_range(1, 6)
	vis_number.texture = load(vis_numbers[value-1])
