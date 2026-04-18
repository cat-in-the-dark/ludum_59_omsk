extends Node2D

@onready var card_prefab: PackedScene = preload("res://scenes/card/card.tscn")
@onready var hand: PlayerHand = $PlayerHand
@onready var dices: Dices = $Dices

func add_card():
	var card: Card = card_prefab.instantiate()
	card.dice = 3
	card.variant = Card.CardVariant.LIGHTNING
	hand.claim(card)
	
func roll():
	dices.roll()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		add_card()

	if Input.is_action_just_pressed("roll"):
		roll()
