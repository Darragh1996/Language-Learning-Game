extends Sprite2D

var player_is_present: bool = false

const lines: Array[String] = [
	"test...",
	"I can talk now!",
	"blah blah blah"
]

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and player_is_present:
		#open()
		print("npc")
		#$Area2D.monitoring = false
		DialogManager.start_dialog(global_position, lines)


func _on_area_2d_area_entered(area: Area2D) -> void:
	player_is_present = true


func _on_area_2d_area_exited(area: Area2D) -> void:
	player_is_present = false
