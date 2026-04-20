extends Node2D

class_name Player

@onready var progress: TextureProgressBar = $HealthBar
@onready var skin: Sprite2D = $Sprite2D

var initPos: Vector2
var hp: int
var max_hp: int

func _ready() -> void:
	initPos = skin.position

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
	animate_dmg()

func animate_dmg():
	var tween = get_tree().create_tween()
	tween.tween_property(skin, "position", initPos + Vector2(-10, 0), 0.15).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(skin, "position", initPos, 0.1).set_trans(Tween.TRANS_QUAD)
