extends Node2D

class_name Card

enum CardVariant {FIRE, COLD, LIGHTNING, HEAL}

class Model:
	var damage: int = 0
	var heal: int = 0
	var dice: int = 0
	var variant: CardVariant = CardVariant.FIRE

	func _init(d: int, v: CardVariant) -> void:
		self.dice = d
		self.variant = v
		if self.variant == CardVariant.FIRE:
			self.damage = G.FIRE_DMG
		if self.variant == CardVariant.COLD:
			self.damage = G.COLD_DMG
		if self.variant == CardVariant.LIGHTNING:
			self.damage = G.LIGHTNING_DMG
		if self.variant == CardVariant.HEAL:
			self.heal = G.HEAL_VALUE

@export var skin_prefab: PackedScene

var model = Model
var skin: CardSkin

func _ready() -> void:
	skin = skin_prefab.instantiate()
	skin.model = model
	self.add_child(skin)
