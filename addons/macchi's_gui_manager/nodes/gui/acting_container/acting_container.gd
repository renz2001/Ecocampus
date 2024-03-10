@tool
extends GUI
class_name ActingContainer 

@export var real_control: Control: 
	set(value): 
		real_control = value
		if real_control && !Engine.is_editor_hint(): 
			name = real_control.name


func add_gui(gui: GUI) -> void: 
	add_child(gui)
	gui.acting_container = self


func _on_visibility_changed() -> void: 
	if real_control: 
		real_control.visible = visible
