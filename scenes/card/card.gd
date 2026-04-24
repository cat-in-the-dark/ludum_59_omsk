extends Node2D

class_name Card

enum CardVariant {FIRE, COLD, LIGHTNING, HEAL}

class Model:
	var damage: int = 0
	var heal: int = 0
	var dice: int = 0
	var variant: CardVariant = CardVariant.FIRE

@export var skin_prefab: PackedScene

var model = Model
var skin: CardSkin

func _ready() -> void:
	skin = skin_prefab.instantiate()
	skin.model = model
	self.add_child(skin)
