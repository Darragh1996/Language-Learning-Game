extends CharacterBody2D

@export var speed := 100

func get_input():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * speed
	if Input.is_action_just_pressed("move_left"):
		%AnimationPlayer.play("walk_left")
	elif Input.is_action_pressed("move_right"):
		%AnimationPlayer.play("walk_right")
	elif Input.is_action_just_pressed("move_up"):
		%AnimationPlayer.play("walk_backward")
	elif Input.is_action_just_pressed("move_down"):
		%AnimationPlayer.play("walk_forward")
		
	
func _physics_process(delta: float) -> void:
	if velocity == Vector2.ZERO:
		%AnimationPlayer.stop()
	get_input()
	move_and_slide()
