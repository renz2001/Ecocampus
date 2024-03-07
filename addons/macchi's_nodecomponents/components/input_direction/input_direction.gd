extends NodeComponent 
class_name InputDirection 

@export var left: String = "move_left"
@export var right: String = "move_right"
@export var up: String = "move_up"
@export var down: String = "move_down"
@export var disabled: bool

var direction: Vector2

func update() -> Vector2: 
	if disabled: 
		return direction
	direction = Input.get_vector(
		left, right, 
		up, down
	)
	return direction

