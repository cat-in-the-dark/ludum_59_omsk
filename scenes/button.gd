extends Sprite2D

class_name ActionButton

signal clicked

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action("click") and event.is_pressed():
		clicked.emit()
