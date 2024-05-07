@tool
extends GUI
class_name ActingContainer 

@export var real_control: Control: 
	set(value): 
		real_control = value
		if real_control: 
			real_control.acting_container = self
			if !Engine.is_editor_hint(): 
				name = real_control.name


func add_gui(gui: GUI) -> void: 
	add_child(gui)
	real_control = gui


func _activated() -> void: 
	real_control.set_active(true)
	
	
func _deactivated() -> void: 
	real_control.set_active(false)
