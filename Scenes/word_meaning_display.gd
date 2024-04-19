extends Control

func set_meaning_display(card_details: Array):
	%IrishWord.text = card_details[0]
	var imageFilePath : String = str("res://Assets/CardImages/", card_details[0], ".png")
	var image = load(imageFilePath)
	%WordImage.texture = image
	%WordTranslation.text = "Meaning: " + card_details[2][0]

func _on_button_pressed() -> void:
	Engine.time_scale = 1
	queue_free()
