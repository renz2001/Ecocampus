extends Resource
class_name DropdownPopupItem

@export var name: String
@export var function: Callable


func _init(_name: String, _function: Callable) -> void: 
	name = _name
	function = _function
