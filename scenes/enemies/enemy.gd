extends Node2D

class_name Enemy

signal Killed

@onready var bar: TextureProgressBar = $HealthBar
@export var dmg: int = 1
@export var hp: int = 10

func _ready() -> void:
	bar.max_value = hp
	bar.value = hp

func killed() -> bool:
	return hp <= 0
	
func attack(state: Game.State):
	state.player.get_damage(dmg)

func get_damage(damage: int):
	hp -= damage
	bar.value = hp
	print("Enemy hp: ", hp)
	if killed():
		print("killed")
		Killed.emit()
