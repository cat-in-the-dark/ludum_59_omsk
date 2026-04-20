extends Node2D

class_name Game

class State:
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
@onready var enemy_timer: Timer = $EnemyAttack
@onready var player: Player = $Player
@onready var shop: Shop = $Shop
@onready var gamelog: RichTextLabel = $Log

var new_cards: Array[Card.Model] = []

func add_to_log(txt: String): 
	gamelog.append_text(txt)

func to_gamewin():
	# todo fade
	get_tree().change_scene_to_file("res://scenes/win/win.tscn")

func to_gameover():
	# todo fade
	get_tree().change_scene_to_file("res://scenes/lose/lose.tscn")
	# restart level and roll back shop state?
	#setup_level(state.lvl)

func on_enemy_killed():
	if G.state.lvl >= 1:
		G.state.dices = 2
	if G.state.lvl >= 4:
		G.state.dices = 3
	G.state.cards.append_array(new_cards)
	G.state.lvl += 1
	# await get_tree().create_timer(1.5).timeout
	get_tree().change_scene_to_file("res://scenes/next_level/next_level.tscn")

func is_shopping():
	return shop.visible

func show_shop():
	shop.show_shop()

func on_upgrade(card: Card.Model):
	shop.hide_shop()
	add_card(card)
	turn()

func setup_level(lvl: int):
	state = State.new()
	state.rolls_per_turn = 1
	state.applies_per_turn = 1
	state.player = player
	state.player.set_max_hp(G.state.player_hp)

	state.enemy = enemies[lvl % len(enemies)].instantiate()
	state.enemy.dmg *= G.damage_scale(lvl)
	state.enemy.hp += G.hp_add(lvl)
	state.enemy.global_position = enemy_spawn.global_position
	state.enemy.Killed.connect(on_enemy_killed)
	self.add_child(state.enemy)

	for card in G.state.cards:
		add_card_to_hand(card)


func _ready() -> void:
	if G.state.lvl > 1:
		$Tutorial.visible = false
	shop.upgrade.connect(on_upgrade)
	roll_btn.clicked.connect(roll)
	enemy_timer.timeout.connect(enemy_turn)
	setup_level(G.state.lvl)
	for i in range(G.state.dices):
		add_dice()
	if len(G.state.cards) > 0:
		show_shop()
	else:
		add_card(shop.get_first_card())
		turn()

func enemy_turn():
	dices.reset()
	if state.enemy.killed():
		return
	var dmg = await state.enemy.attack(state)
	add_to_log("[color=#ff004d]e: %d pure dmg[/color]\n" % dmg)
	turn()

func turn():
	if state.player.killed():
		to_gameover()
		return
	state.rolls = state.rolls_per_turn
	state.applies = state.applies_per_turn
	roll() # autoroll

func add_card_to_hand(model: Card.Model):
	var card: Card = card_prefab.instantiate()
	card.model = model
	hand.claim(card)

func add_card(model: Card.Model):
	new_cards.append(model)
	add_card_to_hand(model)

func dice_clicked(value: int):
	hand.unhighlight(value)
	apply_cards(value)
	$Tutorial.visible = false

func add_dice():
	var dice: Dice = dice_prefab.instantiate()
	dices.claim(dice)
	dice.clicked.connect(dice_clicked)
	dice.hovered.connect(hand.highlight)
	dice.unhovered.connect(hand.unhighlight)

func roll():
	if state.rolls > 0:
		state.rolls -= 1
		dices.roll()
	else:
		#todo sfx
		pass

func _process(_delta: float) -> void:
	if is_shopping():
		return
	
	if Input.is_key_pressed(KEY_1):
		on_enemy_killed()

func apply_cards(dice: int):
	if state.applies <= 0:
		return
	state.applies -= 1
	var applied_cards: Array[Card] = []
	for card in hand.cards:
		if card.model.dice == dice:
			applied_cards.append(card)

	var damage = 0
	for card in applied_cards:
		damage += apply_card(card, applied_cards)
	await state.enemy.get_damage(damage)

	if state.enemy and not state.enemy.killed():
		enemy_timer.start(0.35)

func apply_card(card: Card, applied_cards: Array[Card]):
	var txt = "p: pass\n"
	var damage: int = card.model.damage
	if card.model.variant == Card.CardVariant.FIRE:
		txt = "p: %d fire dmg\n" % damage
		for other_card in applied_cards:
			if other_card.model.variant == Card.CardVariant.COLD:
				damage *= G.FIRE_ON_COLD_MUL
				txt = "p: %d melt dmg\n" % damage
	if card.model.variant == Card.CardVariant.COLD:
		txt = "p: %d ice dmg\n" % damage
		for other_card in applied_cards:
			if other_card.model.variant == Card.CardVariant.LIGHTNING:
				damage *= G.COLD_ON_LIGHT_MUL
				txt = "p: %d shock dmg\n" % damage
	if card.model.variant == Card.CardVariant.LIGHTNING:
		txt = "p: %d electro dmg\n" % damage
		for other_card in applied_cards:
			if other_card.model.variant == Card.CardVariant.FIRE:
				damage *= G.LIGHT_IN_FIRE_MUL
				txt = "p: %d plasma dmg\n" % damage
	if card.model.heal > 0:
		txt = "p: %d heal\n" % card.model.heal
		state.player.hp = clampi(state.player.hp + card.model.heal, 0, state.player.max_hp)

	add_to_log("[color=#008751]%s[/color]" % txt)
	return damage
