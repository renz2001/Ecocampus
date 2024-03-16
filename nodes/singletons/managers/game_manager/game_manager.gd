extends Node

@export var state_chart: StateChart
@export var to_map_picker: ChangeSceneComponent
@export var playing_state: AtomicState
@export var paused_state: AtomicState




func start() -> void: 
	to_map_picker.change()


func is_playing() -> bool: 
	return playing_state.active


func is_paused() -> bool: 
	return paused_state.active


