extends Node2D

class_name Dices

var spacing = 32
var dices: Array[Dice]

func claim(dice: Dice):
	self.add_child(dice)
	dices.append(dice)
	dice.holder = self

func roll():
	for dice in dices:
		dice.roll()

func _process(delta: float) -> void:
	var size = dices.size()
	if size == 0:
		return
	
	for i in range(size):
		dices[i].position.x = i * spacing

func can_select() -> bool:
	var selected = 0
	for dice in dices:
		if dice.selected:
			selected += 1
	return selected < G.MAX_SELECTED
