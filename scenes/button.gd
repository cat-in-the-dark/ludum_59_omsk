extends Sprite2D

class_name ActionButton

@export var apply_btn: Texture2D
@export var roll_btn: Texture2D

signal Clicked

enum State { APPLY, ROLL }

var state: State = State.ROLL

func set_apply_btn():
	state = State.APPLY
	self.texture = apply_btn

func set_roll_btn():
	state = State.ROLL
	self.texture = roll_btn


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action("click") and event.is_pressed():
		Clicked.emit(state)
