extends CharacterBody2D

@export var speed := 400
var last_direction := Vector2.ZERO

# Define rotation speed and maximum rotation angle
var rotation_speed = 30.0
var max_rotation_angle = 15.0 # Degrees
var direction = 1
var is_moving : bool = false

func _process(delta):
	if is_moving:
		# Rotate the sprite
		rotation_degrees += rotation_speed * direction * delta
		
		# Check if the rotation exceeds the bounds
		if rotation_degrees > max_rotation_angle or rotation_degrees < -max_rotation_angle:
			# Reverse direction if it does
			direction *= -1

func get_input():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * speed
	if Input.is_action_just_pressed("move_left"):
		%CharacterSprite.flip_h = 1
	elif Input.is_action_just_pressed("move_right"):
		%CharacterSprite.flip_h = 0
	elif Input.is_action_just_pressed("move_up"):
		%CharacterSprite.frame = 22
	elif Input.is_action_just_pressed("move_down"):
		%CharacterSprite.frame = 0
		
	
func _physics_process(delta: float) -> void:
	if velocity != Vector2.ZERO:
		is_moving = true
	else:
		is_moving = false
	get_input()
	move_and_slide()
	
func update_sprite_orientation():
	pass
