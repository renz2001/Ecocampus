extends Resource
class_name InteractDialogData

@export var description: LabelText
@export var on_button_pressed: Callable
@export var gui_position: Vector2

var caller: Node


func set_caller(value: Node) -> InteractDialogData: 
	caller = value
	return self
	
	
func set_description(value: LabelText) -> InteractDialogData: 
	description = value
	return self
	
	
func set_on_button_pressed(value: Callable) -> InteractDialogData: 
	on_button_pressed = value
	return self
	
	
func set_gui_position(value: Vector2) -> InteractDialogData: 
	gui_position = value
	return self
	
	
