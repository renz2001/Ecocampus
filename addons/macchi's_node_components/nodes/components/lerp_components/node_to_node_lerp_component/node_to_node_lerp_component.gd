## For lerping node properties to another node's properties
@tool
extends BaseNodeLerpComponent
class_name NodeToNodeLerpComponent

@export var start_point: Node: 
	set(value): 
		start_point = value
		_setup_lerp(start_point, "start_point")
		
@export var end_point: Node: 
	set(value): 
		end_point = value
		_setup_lerp(end_point, "end_point")


func _physics_process(delta: float) -> void: 
	update_lerp_points() 
	_float_lerp.percentage = percentage
	_vector2_lerp.percentage = percentage
	if is_lerping(): 
		_set_current()
		interpolated.emit()
	
	
func update_lerp_points() -> void: 
	# To update the start and end points
	start_point = start_point
	end_point = end_point
	#_float_lerp.percentage = percentage
	#_vector2_lerp.percentage = percentage
	#print("SCALING: %s %s" % [_vector2_lerp.start_point, _vector2_lerp.end_point])
	
	
func _set_current() -> void: 
	if !is_instance_valid(current): 
		return
	var value = current.get(property)
	#print(_vector2_lerp.percentage)
	#printerr(value)
	#printerr(_vector2_lerp.current)
	#print(_vector2_lerp.end_point)
	if value is float: 
		current.set(property, _float_lerp.current)
	elif current is Node2D && value is Vector2: 
		current.set(property, _vector2_lerp.current)
		#print(_vector2_lerp.current)


func _set_interpolation(value: TweenArguments) -> void: 
	interpolation = value 
	_float_lerp.interpolation = interpolation
	_vector2_lerp.interpolation = interpolation
	
	
func _is_finished() -> void: 
	#if reset_points_when_finished: 
		#start_point = null
		#end_point = null
	super._is_finished()

