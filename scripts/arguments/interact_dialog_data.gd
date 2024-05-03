extends Resource
class_name InteractDialogData

@export var use_rich_text: bool
@export var description: BaseLabelText
@export var on_button_pressed: Callable
@export var gui_position: Vector2
@export var custom_ok_text: String


var caller: Node

func set_custom_ok_text(value: String) -> InteractDialogData: 
	custom_ok_text = value
	return self
	

func set_caller(value: Node) -> InteractDialogData: 
	caller = value
	return self
	
	
func set_description(value: BaseLabelText) -> InteractDialogData: 
	description = value
	return self
	
	
func set_on_button_pressed(value: Callable) -> InteractDialogData: 
	on_button_pressed = value
	return self
	
	
func set_gui_position(value: Vector2) -> InteractDialogData: 
	gui_position = value
	return self
	
	
