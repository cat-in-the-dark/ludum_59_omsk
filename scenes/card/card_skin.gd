extends Node2D

class_name CardSkin

signal clicked(dice, variant)

var init_pos: Vector2

var vis_icons = {
	Card.CardVariant.FIRE: "res://resources/card_fire.png",
	Card.CardVariant.COLD: "res://resources/card_ice.png",
	Card.CardVariant.LIGHTNING: "res://resources/card_lightning.png",
	Card.CardVariant.HEAL: "res://resources/card_heal.png",
}

var vis_numbers = [
	"res://resources/card-d6/d6-1.tres",
	"res://resources/card-d6/d6-2.tres",
	"res://resources/card-d6/d6-3.tres",
	"res://resources/card-d6/d6-4.tres",
	"res://resources/card-d6/d6-5.tres",
	"res://resources/card-d6/d6-6.tres",
]

var model: Card.Model = Card.Model.new()
var hovered: bool = false

@onready var vis_icon: Sprite2D = $icon
@onready var vis_number: Sprite2D = $number
@onready var vis_highlight: Sprite2D = $highlight

func _ready() -> void:
	init_pos = self.position
	vis_highlight.visible = false
	_update_render()

func _update_render():
	vis_icon.texture = load(vis_icons[model.variant])
	vis_number.texture = load(vis_numbers[model.dice-1])

func update_model(m: Card.Model):
	self.model = m
	_update_render()

func _on_area_2d_mouse_entered() -> void:
	hovered = true

func _on_area_2d_mouse_exited() -> void:
	hovered = false

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("click"):
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
