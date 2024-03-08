extends NodeComponent
class_name MousePositionComponent


func get_position() -> Vector2: 
	return get_viewport().get_mouse_position()
	
	
func get_position_direction_relative_to(global_position: Vector2) -> Array[GlobalVariables.Directions]: 
	var directions: Array[GlobalVariables.Directions] = [GlobalVariables.Directions.NEUTRAL, GlobalVariables.Directions.NEUTRAL]
	if get_position().x > global_position.x: 
		directions[0] = GlobalVariables.Directions.RIGHT
	elif get_position().x < global_position.x: 
		directions[0] = GlobalVariables.Directions.LEFT
		
	if get_position().y < global_position.y: 
		directions[1] = GlobalVariables.Directions.UP
	elif get_position().y > global_position.y: 
		directions[1] = GlobalVariables.Directions.DOWN
		
	return directions
