extends Node2D

class_name Enemy

signal Killed

@onready var skin: Sprite2D = $Sprite2D
@onready var bar: TextureProgressBar = $HealthBar
@export var dmg: int = 1
@export var hp: int = 10
var initPos: Vector2

func _ready() -> void:
	initPos = skin.position
	bar.max_value = hp
	bar.value = hp

func killed() -> bool:
	return hp <= 0

func attack(state: Game.State):
	var tween = get_tree().create_tween()
	tween.tween_property(skin, "position", initPos + Vector2(0, 15), 0.15).set_trans(Tween.TRANS_QUAD)
	tween.tween_callback(state.player.get_damage.bind(dmg))
	tween.tween_property(skin, "position", initPos, 0.1).set_trans(Tween.TRANS_QUAD)

func animate_dmg():
	var tween = get_tree().create_tween()
	tween.tween_property(skin, "position", initPos + Vector2(10, 0), 0.15).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(skin, "position", initPos, 0.1).set_trans(Tween.TRANS_QUAD)

func get_damage(damage: int):
	hp -= damage
	bar.value = hp
	animate_dmg()
	if killed():
		print("killed")
		Killed.emit()
