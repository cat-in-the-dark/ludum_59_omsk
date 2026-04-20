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

# func apply_dice(value: int, state: Game.State, applied_cards: Array[Card]) -> bool:
# 	if value != model.dice:
# 		return false
# 	if model.damage > 0:
# 		var dmg = model.damage
# 		#reactions
		
# 		# if prev_card and prev_card.damage > 0:
# 		# 	if prev_card.variant != model.variant:
# 		# 		dmg *= 2
# 		state.enemy.get_damage(dmg)
# 	if model.heal > 0:
# 		state.player_hp += model.heal
# 	skin.attack()
# 	return true
