extends Node2D

class_name Dices

var spacing = 48
var dices: Array[Dice]

var queue: Array[int] = [1,2,3,4,5,6]

func claim(dice: Dice):
	self.add_child(dice)
	dices.append(dice)
	
func reset_queue():
	queue = [1,2,3,4,5,6]
	queue.shuffle()

func roll():
	for dice in dices:
		if len(queue) == 0:
			reset_queue()
		var value = queue.pop_back()
		dice.set_value(value)

func _ready() -> void:
	reset_queue()

func _process(_delta: float) -> void:
	var size = dices.size()
	if size == 0:
		return
	
	for i in range(size):
		dices[i].position.x = i * spacing

func reset():
	for dice in dices:
		dice.reset()
