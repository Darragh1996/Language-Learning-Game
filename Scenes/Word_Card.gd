extends Control

var isPlayerCard : bool = true
var selected : bool = false
var cards : Array
var rest_point : Vector2 = global_position
var collisionShape : Object
var word : String = "placeholder"
var spotlight : bool = false # keeps track of whether the card should be spotlighted
var is_played : bool = false

func _ready() -> void:
	cards = get_tree().get_nodes_in_group("cards")
	
	if get_parent() != get_tree().root:
		setCard.call_deferred()
	else:
		rest_point = global_position
		
#func _draw() -> void:
	#var shape = %CollisionShape2D.shape
	#draw_rect(Rect2(%CollisionShape2D.position - shape.extents, shape.extents * 2), Color(1, 0, 0, 0.5), false)
		
func setCard(pos : Vector2 = global_position) -> void:
	selected = false
	z_index = 0
	rest_point = pos
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	
func initialize_card(cardInfo : Dictionary, isPlayerCardFlag: bool) -> void:
	isPlayerCard = isPlayerCardFlag
	word = cardInfo.irishWord
	var soundFile : String = str("res://Assets/Sounds/WordPronounciations/", word, ".ogg")
	%WordText.text = word
	var wordSound : Object = load(soundFile)
	%WordSound.stream = wordSound
		
func _process(delta: float) -> void:
	if selected:
		global_position = lerp(global_position, get_global_mouse_position() - (size * 0.5), 25 * delta)
	elif !selected and spotlight and !is_played:
		var target_position : Vector2 = rest_point
		target_position.y -= size.y * 0.5
		global_position = lerp(rest_point, target_position, 50  * delta)
	elif !selected and global_position != rest_point:
		global_position = lerp(global_position, rest_point, 50 * delta)
		
func setMonitoring(val : bool) -> void:
	%CardArea2D.monitoring = val
	
func _on_card_area_2d_mouse_entered() -> void:
	%Timer.stop()
	spotlight = true

func _on_card_area_2d_mouse_exited() -> void:
	if !is_played or global_position != rest_point:
		%Timer.start()

func _on_timer_timeout() -> void:
	spotlight = false
	
func _on_pronounce_button_pressed() -> void:
	%WordSound.play()

func _on_card_area_2d_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	if Input.is_action_just_pressed("left_click") and isPlayerCard:
		for card in cards:
			card.selected = false
			card.z_index = 0
		selected = true
		z_index = 1
		mouse_default_cursor_shape = Control.CURSOR_DRAG
		%Timer.stop()
	if Input.is_action_just_pressed("right_click"):
		selected = false
		z_index = 0
		mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND

