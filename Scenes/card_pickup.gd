extends Area2D

@onready var messageScene : PackedScene = preload("res://Scenes/new_card_message.tscn")

var card_data : Array

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	play_floating_animation()

func play_floating_animation() -> void:
	var tween : Tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	
	var sprite_2d : Sprite2D = $Sprite2D
	var position_offset : Vector2 = Vector2(0.0, 4.0)
	var duration : float = randf_range(0.8, 1.2)
	tween.tween_property(sprite_2d, "position", position_offset, duration)
	tween.tween_property(sprite_2d, "position", -1.0 * position_offset, duration)
	tween.set_loops()

func set_card_data(card_data: Array) -> void:
	self.card_data = card_data

func _on_area_entered(area_that_entered: Area2D) -> void:
	await WordList.add_word(card_data)
	queue_free()
	print(WordList.discoveredWords)
	_display_message()

func _display_message() -> void:
	var message_instance : Control = messageScene.instantiate()
	var camera: Camera2D = get_viewport().get_camera_2d()
	var center_position = camera.get_screen_center_position()
	get_tree().root.get_node("World").add_child.call_deferred(message_instance)
	message_instance.global_position = center_position
	message_instance.scale = Vector2(0.2, 0.2)
	message_instance.set_message_card(card_data)
