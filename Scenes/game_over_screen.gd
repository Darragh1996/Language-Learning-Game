extends Control

func _on_button_pressed() -> void:
	PlayerData.set_position(Vector2.ZERO)
	PlayerData.heal()
	get_tree().change_scene_to_file("res://Scenes/world.tscn")
