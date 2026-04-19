extends Node2D

class_name Enemy

signal Killed

@export var dmg: int = 1
@export var hp: int = 10

func killed() -> bool:
	return hp <= 0
	
func attack(state: Game.State):
	state.player.get_damage(dmg)

func get_damage(damage: int):
	hp -= damage
	print("Enemy hp: ", hp)
	if killed():
		print("killed")
		Killed.emit()
