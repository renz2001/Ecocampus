@tool
extends NodeComponent
class_name TwoPoint5DSpaceSimulator

@export var base_point: Marker2D
@export var point_a: Marker2D
@export var point_b: Marker2D


func get_node_scale(node: Node2D) -> float: 
	#var displacement: Vector2 = Vector2(point_b.position.x - point_a.position.x, point_b.position.y - point_a.position.y)
	#var test = (displacement / point_b.position) + base_scale
	#print(test) 
	#var y_distance: float = - point_b.position.y - point_a.position.y 
	var max: float = point_b.position.y
	var y_base_point_distance: float = node.global_position.y / base_point.global_position.y
	print(base_point.global_position.y / point_b.position.y)
	#printerr(y_base_point_distance)
	#var res = -(lerp(0.0, y_distance, y_base_point_distance) / point_b.position.y)
	var res: float = 0
	#print(y_base_point_distance / y_distance)
	return res
	
	
#func get_weight(position: Vector2) -> float: 
	#var weight: float = 0
	#var distance: float = point_a.position.distance_to(point_b.position)
	##weight = distance / point_b.position
	#weight = Vector2(position.length(), distance).normalized().length()
	#
	#return weight

