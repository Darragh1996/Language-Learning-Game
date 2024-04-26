extends Sprite2D

var player_is_present: bool = false

const lines: Array[String] = [
	"Hello!",
	"Have you seen a {{madra}}",
	"If you want to battle me...",
	"You'll need at least 5 cards"
]

const battleLines: Array[String] = [
	"Let's battle"
]

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and player_is_present:
		if len(WordList.discoveredWords) < 5:
			DialogManager.start_dialog(global_position, lines)
		else:
			DialogManager.start_dialog(global_position, battleLines)
			$Timer.start()
			


func _on_area_2d_area_entered(_area: Area2D) -> void:
	player_is_present = true


func _on_area_2d_area_exited(_area: Area2D) -> void:
	player_is_present = false


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/card_battle.tscn")
