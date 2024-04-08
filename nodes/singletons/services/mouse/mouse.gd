# TODO: Will include double click? 
extends Node


@export var long_press_timer: Timer


#func _ready() -> void: 
	#long_press_timer.paused = false


func is_long_pressed(event: InputEvent) -> bool: 
	#print(long_press_timer.time_left)
	#printerr(long_press_timer.paused)
	long_press_timer.paused = false
	
	if event.is_action_pressed("tap"): 
		#long_press_timer.paused = false
		long_press_timer.start()
		
	elif event.is_action_released("tap"): 
		long_press_timer.paused = true 
	
	return long_press_timer.paused


func is_pressed(event: InputEvent) -> bool: 
	return event.is_action_pressed("tap")
	
	
func is_released(event: InputEvent) -> bool: 
	return event.is_action_released("tap")
	
	
func is_just_pressed() -> bool: 
	return Input.is_action_just_pressed("tap")
