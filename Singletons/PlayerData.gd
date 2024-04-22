extends Node

const MAX_HEALTH: int = 10
var curr_health: int = 10
var curr_position: Vector2

func take_damage(val: int) -> void:
	curr_health -= val
	if curr_health < 0:
		curr_health = 0

func get_health() -> int:
	return curr_health

func heal() -> void:
	curr_health = MAX_HEALTH

func get_position() -> Vector2:
	return curr_position

func set_position(pos: Vector2) -> void:
	curr_position = pos
