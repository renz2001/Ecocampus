## Abstract Class for lerping node properties to another node's properties
@tool
extends BaseLerpComponent
class_name BaseNodeLerpComponent

@export var current: Node

@export var property: String: 
	set(value): 
		property = value
		if !Engine.is_editor_hint() && !current.is_node_ready(): 
			await current.ready
		update_lerp_points()
		#await get_tree().physics_frame
		#_set_current()

@export var _float_lerp: FloatLerpComponent
@export var _vector2_lerp: Vector2LerpComponent


func update_lerp_points() -> void: 
	# To update the start and end points
	#start_point = start_point
	#end_point = end_point
	#_float_lerp.percentage = percentage
	#_vector2_lerp.percentage = percentage
	#_set_current()
	#print("SCALING: %s %s" % [_vector2_lerp.start_point, _vector2_lerp.end_point])
	pass
	
#func ass_update_lerp_points() -> void: 
	#pass
	
	
func _setup_lerp(node: Node, _property: String) -> void: 
	if !is_instance_valid(current) || !is_instance_valid(node): 
		return
	if !Engine.is_editor_hint() && !current.is_node_ready(): 
		await current.ready
	var value = node.get(property)
	#prints(node, property, value)
	#printerr("value: ", value)
	if value is float: 
		_float_lerp.set(_property, value)
		_float_lerp.update_current()
	elif value is Vector2: 
		_vector2_lerp.set(_property, value) 
		_vector2_lerp.update_current()
		
		
func _set_current() -> void: 
	if !is_instance_valid(current): 
		return
	var value = current.get(property)
	if value is float: 
		current.set(property, _float_lerp.current)
	elif current is Node2D && value is Vector2: 
		current.set(property, _vector2_lerp.current)


func _set_interpolation(value: TweenArguments) -> void: 
	interpolation = value 
	if !Engine.is_editor_hint() && !current.is_node_ready(): 
		await current.ready
	if _float_lerp: 
		_float_lerp.interpolation = interpolation
	if _vector2_lerp: 
		_vector2_lerp.interpolation = interpolation
	
	
func set_percentage(value: float) -> void: 
	#if reset_points_when_finished: 
		#start_point = null
		#end_point = null
	if reset_current_when_finished && is_finished(): 
		current = null
	super.set_percentage(value)
