extends Resource
class_name AddGUIConfig


@export var centered: bool
@export var position: Vector2 = Vector2.ZERO
@export var animation: String
@export var is_exclusive: bool


func set_centered(val: bool) -> AddGUIConfig:
	centered = val
	return self

func set_position(val: Vector2) -> AddGUIConfig:
	position = val
	return self

func set_animation(val: String) -> AddGUIConfig:
	animation = val
	return self

func set_is_exclusive(val: bool) -> AddGUIConfig:
	is_exclusive = val
	return self
