extends Node2D

class_name CardSkin

var vis_icons = {
	Card.CardVariant.FIRE: "res://resources/card_fire.png",
	Card.CardVariant.COLD: "res://resources/card_ice.png",
	Card.CardVariant.LIGHTNING: "res://resources/card_lightning.png"
}

var vis_numbers = [
	"res://resources/card-d6/d6-1.tres",
	"res://resources/card-d6/d6-2.tres",
	"res://resources/card-d6/d6-3.tres",
	"res://resources/card-d6/d6-4.tres",
	"res://resources/card-d6/d6-5.tres",
	"res://resources/card-d6/d6-6.tres",
]

var variant: Card.CardVariant
var dice: int

var hovered: bool = false

@onready var vis_icon: Sprite2D = $icon
@onready var vis_number: Sprite2D = $number

func _ready() -> void:
	vis_icon.texture = load(vis_icons[variant])
	vis_number.texture = load(vis_numbers[dice-1])


func _on_area_2d_mouse_entered() -> void:
	hovered = true


func _on_area_2d_mouse_exited() -> void:
	hovered = false
