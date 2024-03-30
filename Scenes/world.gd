extends Node2D

var card_battle : PackedScene = preload("res://Scenes/card_battle.tscn")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("test"):
		get_tree().change_scene_to_packed(card_battle)
