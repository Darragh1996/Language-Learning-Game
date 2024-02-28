extends Control

var vacant : bool = false
var isPlayerDropZone : bool = true
var is_overlapping : bool = false
var Card : Object

func _ready() -> void:
	#%CollisionShape2D.shape = %CollisionShape2D.shape.duplicate()
	#%CollisionShape2D.shape.extents = size / 2
	#%CollisionShape2D.position = size / 2
	
	if is_in_group("opponent_card_drop_zones"):
		isPlayerDropZone = false
	
	for child in get_children():
		if child.is_in_group("cards"):
			vacant = false
			break
		else:
			vacant = true
	
	#if find_child("WordCard") == null:
		#vacant = true
		
#func _draw() -> void:
	#var shape = %CollisionShape2D.shape
	#draw_rect(Rect2(%CollisionShape2D.position - shape.extents, shape.extents * 2), Color(1, 0, 0, 0.5), false)

func _on_area_2d_area_entered(area: Area2D) -> void:
	is_overlapping = true
	Card = area.get_parent()
		
func _on_area_2d_area_exited(_area: Area2D) -> void:
	is_overlapping = false

func _on_child_entered_tree(node: Node) -> void:
	if node.is_in_group("cards"):
		vacant = false

func _on_child_exiting_tree(node: Node) -> void:
	if node.is_in_group("cards"):
		vacant = true

func _on_area_2d_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	if Input.is_action_just_pressed("left_click") and is_overlapping and vacant and isPlayerDropZone:
		Card.selected = false
		Card.is_played = true
		Card.z_index = 0
		Card.setMonitoring(false)
		Card.reparent(self, true)
		Card.setCard(global_position)
		Card.setMonitoring(true)


func _on_area_2d_mouse_entered() -> void:
	if is_overlapping and (!vacant or !isPlayerDropZone):
		Card.mouse_default_cursor_shape = Control.CURSOR_FORBIDDEN
	elif is_overlapping and vacant and isPlayerDropZone:
		Card.mouse_default_cursor_shape = Control.CURSOR_CAN_DROP


func _on_area_2d_mouse_exited() -> void:
	if is_overlapping:
		Card.mouse_default_cursor_shape = Control.CURSOR_DRAG
