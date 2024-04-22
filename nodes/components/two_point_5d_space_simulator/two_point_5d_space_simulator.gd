@tool
extends NodeComponent
class_name TwoPoint5DSpaceSimulator

@export var max_distance_offset: float

@export var base_point: Marker2D
@export var minimum_distance: Marker2D
@export var maximum_distance: Marker2D
@export var clamp_minimum_scale: bool = true

@export var scale_size_offset: int
@export var trans_type: Tween.TransitionType = Tween.TransitionType.TRANS_LINEAR
@export var ease_type: Tween.EaseType = Tween.EaseType.EASE_IN

@export var disabled: bool
@export var debug: bool


func get_space_scale(global_position: Vector2, speed: float) -> float: 
	if disabled: 
		return 1
	
	# Current position of the node
	var node_offset: float = minimum_distance.global_position.y - global_position.y
	
	# Distance between the maximum and the minimum
	var points_distance: float = maximum_distance.global_position.y - minimum_distance.global_position.y
	
	# Node distance divided by his speed
	var elapsed_time: float = node_offset / speed
	
	var duration: float = abs(points_distance / speed)
	
	var minimum: float = maximum_distance.position.y
	
	var maximum: float = (minimum_distance.position.y) - minimum
	
	var current: float = Tween.interpolate_value(maximum, minimum + max_distance_offset, elapsed_time, duration, trans_type, ease_type)
	var percent: float = (current / maximum) + (scale_size_offset / maximum)
	
	var minimum_percent: float = (minimum / maximum * -1) + (scale_size_offset / maximum)
	if debug: 
		print("
			Minimum Distance: %s
			Maximum Distance: %s
			Minimum: %s
			Maximum: %s
			Current: %s
			Percent: %s
		" % [minimum_distance.position.y, maximum_distance.position.y, minimum, maximum, current, percent]
		)
		
	if clamp_minimum_scale && percent >= minimum_percent: 
		return minimum_percent
	elif percent == 0: 
		return 0.1
	return percent


func get_offset_percentage_from_max_distance(global_position: Vector2) -> float: 
	var node_y_distance: float = maximum_distance.global_position.y - global_position.y
	#print("y distance: ", -node_y_distance)
	var node_x_distance: float = maximum_distance.global_position.x - global_position.x
	#print("x distance: ", -node_x_distance)
	var x_offset: float = node_y_distance / node_x_distance
	
	return x_offset
	
	
