extends Resource
class_name GameSaveArguments 

@export var save_name: String = "save_file"
@export var overwrite: bool = false
#@export var create_if_doesnt_exist: bool = true


func set_overwrite(value: bool) -> GameSaveArguments: 
	overwrite = value
	return self
	
	
#func set_create_if_doesnt_exist(value: bool) -> GameSaveArguments: 
	#create_if_doesnt_exist = value
	#return self
	
	
func set_save_name(value: String) -> GameSaveArguments: 
	save_name = value
	return self
	
	
