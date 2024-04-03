@tool
extends NodeComponent
class_name OnControlTapped

signal tapped

@export var control: Control: 
	set(value): 
		control = value
		if !is_node_ready(): 
			await ready
		if !control.is_node_ready(): 
			await control.ready
		if !control.gui_input.is_connected(_on_gui_input): 
			control.gui_input.connect(_on_gui_input)


func _on_gui_input(event: InputEvent) -> void: 
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == 1:
		tapped.emit()
		_on_tapped()
	
	
func _on_tapped() -> void: 
	pass
	
	
