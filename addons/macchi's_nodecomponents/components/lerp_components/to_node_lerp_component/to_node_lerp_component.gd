@tool
extends BaseNodeLerpComponent
class_name ToNodeLerpComponent

@export var end_point: Node: 
	set(value): 
		end_point = value
		if !is_lerping(): 
			_setup_lerp(current, "start_point")
		#printerr(current, current.position)
		_setup_lerp(end_point, "end_point")


func _physics_process(_delta: float) -> void: 
	update_lerp_points() 
	_float_lerp.percentage = percentage
	_vector2_lerp.percentage = percentage
	if is_lerping(): 
		_set_current()
		#printerr("%s: %s" % [self, _vector2_lerp.current])
		interpolated.emit()
	#print(_vector2_lerp.current)
	
	
func update_lerp_points() -> void: 
	# To update the start and end points
	if is_instance_valid(end_point): 
		end_point = end_point
	#_float_lerp.percentage = percentage
	#_vector2_lerp.percentage = percentage
	#super.update_lerp_points()
	#print("SCALING: %s %s" % [_vector2_lerp.start_point, _vector2_lerp.end_point])


func _set_interpolation(value: TweenArguments) -> void: 
	interpolation = value 
	_float_lerp.interpolation = interpolation
	_vector2_lerp.interpolation = interpolation
	
	
func _is_finished() -> void: 
	if reset_end_point_when_finished && !Engine.is_editor_hint(): 
		end_point = null
	super._is_finished()

