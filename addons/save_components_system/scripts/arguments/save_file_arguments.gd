extends Resource
class_name SaveFileArguments

@export var save_data: GameSave
@export var overwrite: bool = false


func set_overwrite(value: bool) -> SaveFileArguments: 
	overwrite = value
	return self
	
	
#func set_create_if_doesnt_exist(value: bool) -> SaveFileArguments: 
	#create_if_doesnt_exist = value
	#return self
	
	
func set_save_data(value: GameSave) -> SaveFileArguments: 
	save_data = value
	return self
	
	
func to_save_data_arguments() -> GameSaveArguments: 
	return GameSaveArguments.new().set_overwrite(overwrite).set_save_name(save_data.name)
