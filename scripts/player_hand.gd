extends Node2D

class_name PlayerHand

var max_spacing = 52
var card_width = 48
var max_width = 324
var cards: Array[Card] = []

func by_card_dice(a: Card, b: Card):
	return a.model.dice < b.model.dice

func claim(card: Card):	
	cards.append(card)
	cards.sort_custom(by_card_dice)
	for i in len(cards):
		cards[i].z_index = i
	self.add_child(card)

func highlight(value: int):
	for card in cards:
		if card.model.dice == value:
			card.skin.highlight()

func unhighlight(_value: int):
	for card in cards:
		card.skin.unhighlight()

func _process(delta: float) -> void:
	var size = cards.size()
	if size == 0:
		return
	var spacing = clampi(float(max_width) / size, 1, max_spacing)

	# maybe second layer?
	# this is dummy approach without the perfect tiling
	var offset = 0
	for i in size:
		var next_pos = Vector2(
			offset,
			cards[i].position.y,
		)
		cards[i].position = cards[i].position.lerp(next_pos, delta * 10)

		if cards[i].skin.hovered:
			offset += max_spacing
		else:
			offset += spacing
