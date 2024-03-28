extends Sprite2D

func open() -> void:
	$AnimationPlayer.play("open_chest")


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	print("clicked")
	var event_is_mouse_click: bool = (
		event is InputEventMouseButton and 
		event.button_index == MOUSE_BUTTON_LEFT and 
		event.is_pressed()
	)
	
	if event_is_mouse_click:
		open()
