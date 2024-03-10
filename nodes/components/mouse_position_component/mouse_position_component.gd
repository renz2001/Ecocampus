extends NodeComponent
class_name MousePositionComponent


func get_position() -> Vector2: 
	return get_viewport().get_mouse_position()
	
	
func get_position_direction_relative_to(global_position: Vector2) -> Array[BaseGlobalEnums.Directions]: 
	var directions: Array[BaseGlobalEnums.Directions] = [BaseGlobalEnums.Directions.NEUTRAL, BaseGlobalEnums.Directions.NEUTRAL]
	if get_position().x > global_position.x: 
		directions[0] = BaseGlobalEnums.Directions.RIGHT
	elif get_position().x < global_position.x: 
		directions[0] = BaseGlobalEnums.Directions.LEFT
		
	if get_position().y < global_position.y: 
		directions[1] = BaseGlobalEnums.Directions.UP
	elif get_position().y > global_position.y: 
		directions[1] = BaseGlobalEnums.Directions.DOWN
		
	return directions
