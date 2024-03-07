@tool
extends NodeComponent
class_name TwoPoint5DSpaceSimulator

@export var max_distance_offset: float

@export var base_point: Marker2D
@export var middle_ground: Marker2D
@export var max_distance: Marker2D


func get_space_scale(node: Node2D) -> float: 
	var node_offset: float = middle_ground.global_position.y - node.global_position.y
	#printerr(middle_ground.global_position.y, " ", node.global_position.y)
	#print("offset ", node.global_position.y - max_distance.global_position.y)
	var points_distance: float = max_distance.global_position.y - middle_ground.global_position.y
	#print("max distance offset: ", -points_distance + max_distance_offset)
	#printerr("node offset: ", node_offset)
	#printerr("point distance: ", -points_distance)
	var weight: float = node_offset / (-points_distance + max_distance_offset)
	#printerr("weight: ", weight)
	var current: float = lerp(max_distance.position.y, middle_ground.position.y, weight) 
	var percent: float = current / max_distance.position.y
	#printerr("percent: ", percent)
	
	if percent == 0: 
		return 0.1
	return percent

