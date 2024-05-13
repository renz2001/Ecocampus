extends Resource
class_name History 

@export var data: Array = [] 


func add(value) -> void: 
	data.append(value)
	
	
func back(): 
	return data.pop_back()
	
	
