extends Node2D

class_name Player

@onready var progress: TextureProgressBar = $HealthBar

var hp: int
var max_hp: int

func killed() -> bool:
	return hp <= 0

func set_max_hp(amount: int):
	print("Player set hp: ", amount)
	max_hp = amount
	hp = max_hp
	progress.max_value = max_hp
	progress.value = max_hp

func get_damage(damage: int):
	hp -= damage
	print("Player got dmg=", damage, " hp=", hp)
	progress.value = hp
