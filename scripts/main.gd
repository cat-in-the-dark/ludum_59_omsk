extends Node2D

class_name Game

@export var card_prefab: PackedScene
@export var dice_prefab: PackedScene
@onready var hand: PlayerHand = $PlayerHand
@onready var dices: Dices = $Dices

func _ready() -> void:
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


func _on_action_button_clicked(state: ActionButton.State) -> void:
	print("BUM", state)
