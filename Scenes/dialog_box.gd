extends MarginContainer

@onready var label = $MarginContainer/Label
@onready var timer = $CharacterDisplayTimer

const MAX_WIDTH = 256

var text = ""
var char_index = 0

var char_time = 0.03
var space_time = 0.06
var punctuation_time = 0.2

signal finished_displaying()

func display_text(text_to_display: String):
	text = text_to_display
	label.text = text_to_display
	
	await resized
	custom_minimum_size.x = min(size.x, MAX_WIDTH)
	
	if size.x > MAX_WIDTH:
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized 
		await resized
		custom_minimum_size.y = size.y
		
	global_position.x -= size.x / 2
	global_position.y -= size.y + 30
	
	label.text = ""
	_display_character()

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
