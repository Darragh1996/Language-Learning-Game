extends Sprite2D

var player_is_present: bool = false
var card_pickup : PackedScene = preload("res://Scenes/card_pickup.tscn")
var random_card_data : Array

func _ready() -> void:
	random_card_data = WordList.get_random()

func open() -> void:
	$Area2D.input_pickable = false
	$AnimationPlayer.play("open_chest")
	_spawn_card()

func _spawn_card() -> void:
	var card_instance : Node2D = card_pickup.instantiate()
	add_child(card_instance)
	card_instance.set_card_data(random_card_data)
	
	var random_angle := randf_range(0.0, 2.0 * PI)
	var random_direction := Vector2(1.0, 0.0).rotated(random_angle)
	var random_distance := randf_range(15.0, 30.0)
	var land_position := random_direction * random_distance

	const FLIGHT_TIME := 0.4
	const HALF_FLIGHT_TIME := FLIGHT_TIME / 2.0


	var tween := create_tween()
	tween.set_parallel()
	card_instance.scale = Vector2(0.25, 0.25)
	tween.tween_property(card_instance, "scale", Vector2(1.0, 1.0), HALF_FLIGHT_TIME)
	tween.tween_property(card_instance, "position:x", land_position.x, FLIGHT_TIME)

	tween = create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	tween.set_ease(Tween.EASE_OUT)
	var jump_height := randf_range(30.0, 80.0)
	tween.tween_property(card_instance, "position:y", land_position.y - jump_height, HALF_FLIGHT_TIME)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(card_instance, "position:y", land_position.y, HALF_FLIGHT_TIME)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and player_is_present:
		open()
		$Area2D.monitoring = false


func _on_area_2d_area_entered(_area: Area2D) -> void:
	player_is_present = true


func _on_area_2d_area_exited(_area: Area2D) -> void:
	player_is_present = false
