extends Sprite2D

class_name ActionButton

signal Clicked

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action("click") and event.is_pressed():
		Clicked.emit()
