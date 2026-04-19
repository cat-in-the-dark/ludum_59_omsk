extends Node2D

class_name Game

class State:
	var lvl: int
	var player: Player
	var enemy: Enemy
	var rolls: int
	var applies: int
	var rolls_per_turn: int
	var applies_per_turn: int

var state: State

@export var enemies: Array[PackedScene]
@export var card_prefab: PackedScene
@export var dice_prefab: PackedScene
@onready var hand: PlayerHand = $PlayerHand
@onready var dices: Dices = $Dices
@onready var enemy_spawn: Node2D = $EnemySpawn
@onready var roll_btn: ActionButton = $RollButton
@onready var apply_btn: ActionButton = $ApplyButton
@onready var enemy_timer: Timer = $EnemyAttack
@onready var player: Player = $Player

func to_gamewin():
	# todo fade
	get_tree().change_scene_to_file("res://scenes/win.tscn")

func to_gameover():
	# todo fade
	get_tree().change_scene_to_file("res://scenes/lose.tscn")

func on_enemy_killed():
	print("ENEMY KILLED")
	setup_level(state.lvl + 1)


func setup_level(lvl: int):
	if state and state.enemy:
		state.enemy.Killed.disconnect(on_enemy_killed)
		self.remove_child(state.enemy)

	if lvl >= len(enemies):
		print("WIN")
		call_deferred("to_gamewin")
		return

	state = State.new()
	state.rolls_per_turn = 1
	state.applies_per_turn = 1
	state.lvl = lvl
	state.player = player
	state.player.set_max_hp(G.PLAYER_MAX_HP)
	if lvl == 0:
		state.enemy = enemies[lvl].instantiate()
		state.enemy.global_position = enemy_spawn.global_position
		state.enemy.Killed.connect(on_enemy_killed)
		self.add_child(state.enemy)


func _ready() -> void:
	roll_btn.Clicked.connect(roll)
	apply_btn.Clicked.connect(apply_cards)
	enemy_timer.timeout.connect(enemy_turn)
	setup_level(0)
	for i in range(G.MAX_DICES):
		add_dice()
	turn()

func enemy_turn():
	dices.reset()
	if state.enemy.killed():
		return
	print("Enemy attack")
	state.enemy.attack(state)
	turn()

func turn():
	print("Player turn")
	if state.player.killed():
		to_gameover()
		return
	state.rolls = state.rolls_per_turn
	state.applies = state.applies_per_turn

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
	if state.rolls > 0:
		state.rolls -= 1
		dices.roll()
	else:
		#todo sfx
		pass

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		add_card()

	if Input.is_action_just_pressed("roll"):
		roll()
		
	if Input.is_key_pressed(KEY_N):
		setup_level(state.lvl + 1)

func apply_cards():
	var values = dices.selected_dices()
	if len(values) == 0:
		print("Must select")
		# TODO: make it impossible to ckick
		return

	if state.applies <= 0:
		return
	state.applies -= 1
	print("Applying", values)
	var prev_card: Card = null
	for value in values:
		for card in hand.cards:
			if card.apply_dice(value, state, prev_card):
				prev_card = card

	enemy_timer.start(0.5)
