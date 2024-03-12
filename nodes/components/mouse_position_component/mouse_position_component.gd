extends Node2D
class_name MousePositionComponent



func get_position_direction_relative_to(node_global_position: Vector2) -> Array[BaseGlobalEnums.Directions]: 
	var directions: Array[BaseGlobalEnums.Directions] = [BaseGlobalEnums.Directions.NEUTRAL, BaseGlobalEnums.Directions.NEUTRAL]
	if get_global_mouse_position().x > node_global_position.x: 
		directions[0] = BaseGlobalEnums.Directions.RIGHT
	elif get_global_mouse_position().x < node_global_position.x: 
		directions[0] = BaseGlobalEnums.Directions.LEFT
		
	if get_global_mouse_position().y < node_global_position.y: 
		directions[1] = BaseGlobalEnums.Directions.UP
	elif get_global_mouse_position().y > node_global_position.y: 
		directions[1] = BaseGlobalEnums.Directions.DOWN
		
	return directions
