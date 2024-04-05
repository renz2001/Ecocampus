extends Resource
class_name Achievement

signal unlocked

@export var title: String
@export var task_description: String


var is_unlocked: bool: 
	set(value): 
		is_unlocked = value
		if is_unlocked: 
			unlocked.emit()
	
	
func unlock() -> void: 
	is_unlocked = true
	
	
