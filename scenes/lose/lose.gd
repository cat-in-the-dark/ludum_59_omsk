extends Node2D

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		G.restart()
		get_tree().change_scene_to_file("res://scenes/game/game.tscn")

	if Input.is_action_just_pressed("next"):
		G.restart()
		get_tree().change_scene_to_file("res://scenes/game/game.tscn")
