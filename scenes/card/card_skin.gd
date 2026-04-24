extends Node2D

class_name CardSkin

signal clicked(dice, variant)

var init_pos: Vector2

@export var icons_textures: Dictionary[Card.CardVariant, Texture2D] = {}
@export var numbers_texturesd: Array[Texture2D] = []

var model: Card.Model = Card.Model.new()
var hovered: bool = false

@onready var vis_icon: TextureButton = $Button
@onready var vis_number: Sprite2D = $number
@onready var vis_highlight: Sprite2D = $highlight

func _ready() -> void:
	init_pos = self.position
	vis_highlight.visible = false
	_update_render()

func _update_render():
	vis_icon.texture_normal = icons_textures[model.variant]
	vis_number.texture = numbers_texturesd[model.dice-1]

func update_model(m: Card.Model):
	self.model = m
	_update_render()

func _on_button_mouse_entered() -> void:
	hovered = true

func _on_button_mouse_exited() -> void:
	hovered = false

func on_pressed():
	clicked.emit(model)

func highlight():
	vis_highlight.visible = true

func unhighlight():
	vis_highlight.visible = false

func attack():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", init_pos + Vector2(0, -15), 0.15).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(self, "position", init_pos, 0.1).set_trans(Tween.TRANS_QUAD)
	await tween.finished
