@tool
extends OnPressedComponent
class_name OnPressedScale

@export var node: Node: 
	set(value): 
		node = value
		if !is_node_ready(): 
			await ready
		scale_lerp.node = node
		scale_lerp.start_point = start_scale
		scale_lerp.end_point = end_scale
		
		
@export var tween: TweenArguments: 
	set(value): 
		tween = value
		if !is_node_ready(): 
			await ready
		scale_lerp.interpolation = tween
		
@export var start_scale: Vector2 = Vector2.ZERO: 
	set(value): 
		start_scale = value
		if !is_node_ready(): 
			await ready
		scale_lerp.start_point = start_scale
		
@export var end_scale: Vector2 = Vector2.ONE: 
	set(value): 
		end_scale = value
		if !is_node_ready(): 
			await ready
		scale_lerp.end_point = end_scale
		
@export_range(0, 1) var percentage: float: 
	set(value): 
		percentage = value
		if !is_node_ready(): 
			await ready
		scale_lerp.percentage = percentage
	
@export var scale_lerp: Vector2PropertyLerpComponent

@export var node_is_control_scale_from_center: bool


func _on_pressed() -> void: 
	play()
	
	
func play() -> void: 
	if node_is_control_scale_from_center:
		node.pivot_offset = node.size / 2
	else: 
		node.pivot_offset = Vector2.ZERO
	scale_lerp.play()
	
	
