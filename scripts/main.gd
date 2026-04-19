extends Node2D

class_name Game

class State:
	var lvl: int
	var player_hp: int
	var enemy: Enemy

var state: State

@export var enemies: Array[PackedScene]
@export var card_prefab: PackedScene
@export var dice_prefab: PackedScene
@onready var hand: PlayerHand = $PlayerHand
@onready var dices: Dices = $Dices
@onready var enemy_spawn: Node2D = $EnemySpawn

func to_gamewin():
	# todo fade
	get_tree().change_scene_to_file("res://scenes/win.tscn")

func to_gameover():
	# todo fade
	get_tree().change_scene_to_file("res://scenes/lose.tscn")

func setup_level(lvl: int):
	if state and state.enemy:
		self.remove_child(state.enemy)
	
	if lvl >= len(enemies):
		print("WIN")
		call_deferred("to_gamewin")
		return

	state = State.new()
	state.lvl = lvl
	state.player_hp = G.PLAYER_MAX_HP
	if lvl == 0:
		var enemy: Enemy = enemies[lvl].instantiate()
		enemy.global_position = enemy_spawn.global_position
		self.add_child(enemy)
	

func _ready() -> void:
	setup_level(0)
	for i in range(3):
		add_dice()

func add_card():
	var card: Card = card_prefab.instantiate()
	# demo
	card.dice = randi_range(1, 6)
	card.variant = [
		Card.CardVariant.LIGHTNING,
		Card.CardVariant.FIRE,
		Card.CardVariant.COLD
	].pick_random()
	hand.claim(card)

func add_dice():
	var dice: Dice = dice_prefab.instantiate()
	dices.claim(dice)

func roll():
	dices.roll()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		add_card()

	if Input.is_action_just_pressed("roll"):
		roll()
		
	if Input.is_key_pressed(KEY_N):
		setup_level(state.lvl + 1)

func apply_cards():
	var values = dices.get_dice_values()
	for value in values:
		for card in hand.cards:
			card.apply_dice(value)

func _on_action_button_clicked(state: ActionButton.State) -> void:
	if state == ActionButton.State.ROLL:
		roll()
	if state == ActionButton.State.APPLY:
		apply_cards()
