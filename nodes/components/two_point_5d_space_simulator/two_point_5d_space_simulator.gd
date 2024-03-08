@tool
extends NodeComponent
class_name TwoPoint5DSpaceSimulator

@export var max_distance_offset: float

@export var base_point: Marker2D
@export var minimum_distance: Marker2D
@export var max_distance: Marker2D

@export var trans_type: Tween.TransitionType = Tween.TransitionType.TRANS_CUBIC
@export var ease_type: Tween.EaseType = Tween.EaseType.EASE_IN


#func get_space_scale(global_position: Vector2) -> float: 
	#var node_offset: float = minimum_distance.global_position.y - global_position.y
	##printerr(minimum_distance.global_position.y, " ", node.global_position.y)
	##print("offset ", node.global_position.y - max_distance.global_position.y)
	#var points_distance: float = max_distance.global_position.y - minimum_distance.global_position.y
	##print("max distance offset: ", -points_distance + max_distance_offset)
	##printerr("node offset: ", node_offset)
	##printerr("point distance: ", -points_distance)
	#var weight: float = node_offset / (-points_distance + max_distance_offset)
	##printerr("weight: ", weight)
	#var current: float = lerp(max_distance.position.y, minimum_distance.position.y, weight) 
	#var percent: float = current / max_distance.position.y
	##printerr("percent: ", percent)
	#
	#if percent == 0: 
		#return 0.1
	#return percent


func get_space_scale(global_position: Vector2, speed: float, trans: Tween.TransitionType = trans_type, ease: Tween.EaseType = ease_type) -> float: 
	var node_offset: float = minimum_distance.global_position.y - global_position.y
	var points_distance: float = max_distance.global_position.y - minimum_distance.global_position.y
	var weight: float = node_offset / speed
	var duration: float = abs(points_distance / speed)
	#print(max_distance.position.x)
	var min: float = max_distance.position.y
	var max: float = (minimum_distance.position.y) - min
	var current: float = Tween.interpolate_value(max, min + max_distance_offset, node_offset / speed, duration, trans, ease)
	var percent: float = current / max
	#printerr("current: ", current)
	if percent == 0: 
		return 0.1
	return percent


func get_offset_percentage_from_max_distance(global_position: Vector2) -> float: 
	var node_y_distance: float = max_distance.global_position.y - global_position.y
	#print("y distance: ", -node_y_distance)
	var node_x_distance: float = max_distance.global_position.x - global_position.x
	#print("x distance: ", -node_x_distance)
	var x_offset: float = node_y_distance / node_x_distance
	
	#printerr(x_offset)
	#var y_offset: float = 
	return x_offset
	
	
