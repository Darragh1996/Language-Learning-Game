extends Control

var selected : bool = false
var rest_point : Vector2
var rest_nodes : Array = []

func _ready() -> void:
	rest_nodes = get_tree().get_nodes_in_group("card_zone")
	rest_point = rest_nodes[0].global_position
	rest_nodes[0].select()
	
func initialize_card(cardInfo : Array) -> void:
	var word : String = cardInfo[0]
	var soundFile : String = str("res://Assets/Sounds/WordPronounciations/", word, ".ogg")
	%WordText.text = word
	var wordSound : Object = load(soundFile)
	%WordSound.stream = wordSound

func _on_pronounce_btn_pressed() -> void:
	%WordSound.play()

func _physics_process(delta: float) -> void:
	var target_position = get_global_mouse_position() - size * 0.5
	if selected:
		global_position = lerp(global_position, target_position, 25 * delta)
	else:
		global_position = lerp(global_position, rest_point, 10 * delta)

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("click"):
		selected = true
		
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
		selected = false
		var shortest_dist = 75
		for child in rest_nodes:
			var distance = global_position.distance_to(child.global_position)
			if distance < shortest_dist:
				child.select()
				rest_point = child.global_position
				shortest_dist = distance
				#var global_tranform = self.global_transform
				get_parent().remove_child(self)
				child.add_child(self)
				#self.global_transform = global_tranform
			 
