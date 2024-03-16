extends Resource
class_name Achievement

signal completed

@export var title: String
@export var task_description: String

var is_completed: bool: 
	set(value): 
		is_completed = value
		if is_completed: 
			completed.emit()


func _condition() -> bool: 
	return false
	
	
func update() -> void: 
	if completed: 
		return
		
	if _condition(): 
		is_completed = true
	
	
