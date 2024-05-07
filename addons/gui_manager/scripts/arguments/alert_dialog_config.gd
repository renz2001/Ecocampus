extends Resource
class_name AlertDialogConfig


@export var description: String

@export var yes_func: Callable
@export var no_func: Callable

@export var close_when_yes_pressed: bool = true
@export var close_when_no_pressed: bool = true

func set_description(val: String) -> AlertDialogConfig: 
	description = val
	return self
	
	
func set_yes_func(val: Callable) -> AlertDialogConfig: 
	yes_func = val
	return self
	
	
func set_no_func(val: Callable) -> AlertDialogConfig: 
	no_func = val
	return self
	
	
