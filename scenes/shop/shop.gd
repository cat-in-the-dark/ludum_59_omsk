extends Node2D
class_name Shop

@onready var items: Array[CardSkin] = [
	$visual,
	$visual2,
	$visual3
]

signal upgrade(card)

func _ready() -> void:
	for item in items:
		item.clicked.connect(selected)

func hide_shop():
	self.visible = false

func generate_card(dice: int):
	var model = Card.Model.new()
	model.dice = dice
	model.variant = [
		Card.CardVariant.LIGHTNING,
		Card.CardVariant.FIRE,
		Card.CardVariant.COLD,
		Card.CardVariant.HEAL
	].pick_random()
	if model.variant == Card.CardVariant.HEAL:
		model.heal = G.HEAL_VALUE
	if model.variant == Card.CardVariant.FIRE:
		model.damage = G.FIRE_DMG
	if model.variant == Card.CardVariant.COLD:
		model.damage = G.COLD_DMG
	if model.variant == Card.CardVariant.LIGHTNING:
		model.damage = G.LIGHTNING_DMG
	return model
	
func get_first_card():
	var model = Card.Model.new()
	model.dice = randi_range(1, 6)
	model.variant = [
		Card.CardVariant.LIGHTNING,
		Card.CardVariant.FIRE,
		Card.CardVariant.COLD,
	].pick_random()
	if model.variant == Card.CardVariant.FIRE:
		model.damage = G.FIRE_DMG
	if model.variant == Card.CardVariant.COLD:
		model.damage = G.COLD_DMG
	if model.variant == Card.CardVariant.LIGHTNING:
		model.damage = G.LIGHTNING_DMG
	return model

func show_shop():
	self.visible = true
	var dices = [1,2,3,4,5,6]
	dices.shuffle()
	for i in range(3):
		var model = generate_card(dices[i])
		items[i].update_model(model)

func selected(card: Card.Model):
	upgrade.emit(card)
