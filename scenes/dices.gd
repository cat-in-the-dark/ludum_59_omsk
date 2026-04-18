extends Node2D

class_name Dices

@export var dices: Array[Dice]

func roll():
	for dice in dices:
		dice.roll()
