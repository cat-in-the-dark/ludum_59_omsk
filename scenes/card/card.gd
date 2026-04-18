extends Node2D

class_name Card

enum CardVariant {FIRE, COLD, LIGHTNING}

@export var variant: CardVariant = CardVariant.FIRE
@export_range(1, 6) var dice: int = 1
@export var skin_prefab: PackedScene

var skin: CardSkin

func _ready() -> void:
	skin = skin_prefab.instantiate()
	skin.dice = dice
	skin.variant = variant
	self.add_child(skin)
