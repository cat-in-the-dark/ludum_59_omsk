extends Node2D
class_name Shop

@onready var items: Array[CardSkin] = [
	$visual,
	$visual2,
	$visual3,
	$visual4
]

signal upgrade(card)

func _ready() -> void:
	for item in items:
		item.clicked.connect(selected)
	generate_shop()

func hide_shop():
	self.visible = false
	
func get_first_card() -> Card.Model:
	return Card.Model.new(
		randi_range(1, 6),
		Card.CardVariant.FIRE,
	)

func generate_shop_cards() -> Array[Card.Model]:
	var shop_cards: Array[Card.Model] = []
	var variants = [
		Card.CardVariant.LIGHTNING,
		Card.CardVariant.FIRE,
		Card.CardVariant.COLD,
		Card.CardVariant.HEAL
	]
	variants.shuffle()
	for i in len(items):
		shop_cards.append(Card.Model.new(
			randi_range(1, 6),
			variants[i % len(variants)]
		))
	return shop_cards

func generate_shop():
	var models = generate_shop_cards()
	for i in len(items):
		items[i].update_model(models[i])

func show_shop():
	self.visible = true
	generate_shop()

func selected(card: Card.Model):
	upgrade.emit(card)
