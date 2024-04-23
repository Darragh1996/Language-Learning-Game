extends MarginContainer

#@onready var label = $MarginContainer/Label
var dictionary_message : PackedScene = preload("res://Scenes/word_meaning_display.tscn")
@onready var timer = $CharacterDisplayTimer
var label

const MAX_WIDTH = 256

var text = ""
var char_index = 0

var char_time = 0.03
var space_time = 0.06
var punctuation_time = 0.2

var curr_node: Node

signal finished_displaying()

func display_text(text_to_display: String):
	var regex = RegEx.new()
	regex.compile("{{(.*?)}}|([^{}]*[^{} ]+[^{}]*)")
	
	var regexResults = regex.search_all(text_to_display)
	for el in regexResults:
		if el.get_string(2) != "":
			text = el.get_string(2)
			label = Label.new()
			label.modulate = Color(0, 0, 0, 1)
			$MarginContainer/HBoxContainer.add_child(label)
			label.text = text_to_display
			await resized
			custom_minimum_size.x = min(size.x, MAX_WIDTH)
			
			if size.x > MAX_WIDTH:
				label.autowrap_mode = TextServer.AUTOWRAP_WORD
				await resized # wait for x resize
				await resized # wait for y resize
				custom_minimum_size.y = size.y
				
			global_position.x -= size.x / 2
			global_position.y -= size.y + 30
			
			label.text = ""
			curr_node = label
			await _display_character()
		elif el.get_string(1) != "":
			var button = Button.new()
			$MarginContainer/HBoxContainer.add_child(button)
			curr_node = button
			button.text = el.get_string(1)
			button.pressed.connect(_on_button_pressed.bind(WordList.get_word(el.get_string(1))))

func _on_button_pressed(wordInfo: Array) -> void:
	#print(wordInfo[2][0])
	var dict_instance = dictionary_message.instantiate()
	
	var camera: Camera2D = get_viewport().get_camera_2d()
	var center_position = camera.get_screen_center_position()
	get_tree().root.get_node("World").add_child.call_deferred(dict_instance)
	dict_instance.global_position = center_position
	dict_instance.scale = Vector2(0.2, 0.2)
	dict_instance.set_meaning_display(wordInfo)

func _display_character():
	label.text += text[char_index]
	
	char_index += 1
	if char_index >= text.length():
		finished_displaying.emit()
		return
	
	match text[char_index]:
		"!", ".", ",", "?": # punctuation
			timer.start(punctuation_time)
		" ": # space characters
			timer.start(space_time)
		_: # all other characters
			timer.start(char_time)


func _on_character_display_timer_timeout() -> void:
	_display_character()
