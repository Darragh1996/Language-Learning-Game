extends Node2D

@onready var player_position: Vector2 = PlayerData.get_position()
#var card_battle : PackedScene = preload("res://Scenes/card_battle.tscn")

func _ready() -> void:
	print("player position: " + str(player_position))
	if player_position:
		%PlayerCharacter.position = player_position

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("test"):
		PlayerData.set_position(%PlayerCharacter.position)		
		get_tree().change_scene_to_file("res://Scenes/card_battle.tscn")
