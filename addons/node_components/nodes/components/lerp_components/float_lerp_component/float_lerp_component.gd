@tool
extends BaseLerpComponent
class_name FloatLerpComponent

@export var start_point: float
@export var end_point: float

@export var current: float: 
	set(value): 
		#if !Engine.is_editor_hint() && !RoomManager.is_room_ready: 
			#await RoomManager.room_is_ready
		previous_current = current
		current = value

var previous_current: float


func _calculate() -> float: 
	return Tween.interpolate_value(start_point, end_point - start_point, elapsed_time, interpolation.duration, interpolation.transition_type, interpolation.ease_type)


func _physics_process(_delta: float) -> void: 
	if !interpolation: 
		return
	if is_lerping(): 
		#printerr(self, _calculate())
		update_current()
		interpolated.emit(current)


func update_current() -> void: 
	current = _calculate() 


func _is_finished() -> void: 
	if reset_start_point_when_finished && !Engine.is_editor_hint(): 
		start_point = 0
	if reset_end_point_when_finished && !Engine.is_editor_hint(): 
		end_point = 0
	if reset_current_when_finished: 
		current = 0
	super._is_finished()
		
