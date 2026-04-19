extends Node2D

class_name Card

enum CardVariant {FIRE, COLD, LIGHTNING}

@export var variant: CardVariant = CardVariant.FIRE
@export_range(1, 6) var dice: int = 1
@export var damage: int = 1
@export var heal: int = 0
@export var skin_prefab: PackedScene

var skin: CardSkin

func _ready() -> void:
	skin = skin_prefab.instantiate()
	skin.dice = dice
	skin.variant = variant
	self.add_child(skin)

func apply_dice(value: int, state: Game.State, prev_card: Card) -> bool:
	if value != dice:
		return false
	if damage > 0:
		var dmg = damage
		#reactions
		if prev_card and prev_card.damage > 0:
			if prev_card.variant != variant:
				dmg *= 2
		print("Apply dice=", value, " card=", variant, " damage=", dmg, "prev=", prev_card)
		state.enemy.get_damage(dmg)
	if heal > 0:
		print("Apply dice=", value, " card=", variant, " heal=", heal)
		state.player_hp += heal
	# todo tun animation
	return true
