## Abstract Class and Scene for lerp components 
extends NodeComponent
class_name BaseLerpComponent

signal finished
signal is_zeroed

signal interpolated(value)

@export var reset_all_when_finished: bool: set = set_reset_all_when_finished
@export var reset_percentage_when_finished: bool

# Implement the function of this for the child classes 
@export var reset_start_point_when_finished: bool
@export var reset_end_point_when_finished: bool
@export var reset_current_when_finished: bool

@export var process_enabled: bool = true: 
	set(value): 
		process_enabled = value
		set_physics_process(process_enabled)
@export_range(0, 1) var percentage: float: set = set_percentage

@export var interpolation: TweenArguments: set = _set_interpolation


var previous_percentage: float = 0
var elapsed_time: float = 0: 
	get: 
		var new: float = 0
		if interpolation.duration == 0: 
			return 0
		new = percentage * interpolation.duration
		return new


func play(to: float = 1) -> void: 
	make_tween(to).play() 


func make_tween(to: float = 1) -> Tween: 
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "percentage", to, interpolation.duration)
	tween.finished.connect(
		func():
			finished.emit()
	, CONNECT_ONE_SHOT
	)
	return tween


func _set_interpolation(value: TweenArguments) -> void: 
	interpolation = value
	#if interpolation && interpolation.duration <= 0: 
		#push_error("%s: interpolation duration cannot be 0. " % self)


func set_percentage(value: float) -> void: 
	previous_percentage = percentage
	percentage = value
	if is_finished(): 
		_is_finished()
		if reset_percentage_when_finished: 
			percentage = 0
		finished.emit()
	elif value == 0: 
		is_zeroed.emit()
	
	
# Virtual Function
func _is_finished() -> void: 
	pass
	
	
func set_reset_all_when_finished(value: bool) -> void: 
	reset_all_when_finished = value
	reset_current_when_finished = value
	reset_percentage_when_finished = value
	reset_end_point_when_finished = value
	reset_start_point_when_finished = value


func is_lerping() -> bool: 
	return percentage > 0


func is_finished() -> bool: 
	return percentage == 1


func _get_configuration_warnings() -> PackedStringArray: 
	var warnings = []
	if !interpolation: 
		warnings.append("interpolation needs to not be null.")
	if interpolation && interpolation.duration <= 0: 
		warnings.append("interpolation duration cannot be 0.")
	return warnings

