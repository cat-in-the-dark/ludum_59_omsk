extends Node

var LIGHTNING_DMG = 1
var COLD_DMG = 1
var FIRE_DMG = 2
var HEAL_VALUE = 3

var FIRE_ON_COLD_MUL = 2 # 4 + 1
var COLD_ON_LIGHT_MUL = 4 # 4 + 1
var LIGHT_IN_FIRE_MUL = 3 # 3 + 2

class State:
	var lvl: int = 0
	var cards: Array[Card.Model] = []
	var player_hp: int = 10
	var dices: int = 2

var state = State.new()

func restart():
	state = State.new()
