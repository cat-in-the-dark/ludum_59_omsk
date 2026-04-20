extends Node2D
class_name Shop

@onready var items: Array[CardSkin] = [
	$visual,
	$visual2,
	$visual3
]

signal upgrade(dice, variant)

func _ready() -> void:
	for item in items:
		item.clicked.connect(selected)

func hide_shop():
	self.visible = false

func show_shop():
	self.visible = true
	for item in items:
		item.generate()

func selected(dice: int, variant: Card.CardVariant):
	upgrade.emit(dice, variant)
