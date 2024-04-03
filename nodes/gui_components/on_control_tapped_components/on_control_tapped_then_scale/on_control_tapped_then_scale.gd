extends OnControlTapped
class_name OnControlTappedThenScale


@export var node: Node: 
	set(value): 
		node = value
		on_pressed_scale.node = node

@export var on_pressed_scale: OnPressedScale


func _on_tapped() -> void: 
	on_pressed_scale.play()


