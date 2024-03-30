extends Control

func _ready() -> void:
	Engine.time_scale = 0

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		Engine.time_scale = 1
		queue_free()

func set_message_card(card_details: Array):
	var cd : Dictionary = {"irishWord": card_details[0]}
	%PictureCard.initialize_card(cd, false)
	%MeaningLabel.text = card_details[0] + " / " + card_details[2][0]
