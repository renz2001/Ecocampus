extends Resource
class_name SaveFileArguments

@export var save_data: GameSaveData
@export var overwrite: bool = false


func set_overwrite(value: bool) -> SaveFileArguments: 
	overwrite = value
	return self
	
	
#func set_create_if_doesnt_exist(value: bool) -> SaveFileArguments: 
	#create_if_doesnt_exist = value
	#return self
	
	
func set_save_data(value: GameSaveData) -> SaveFileArguments: 
	save_data = value
	return self
	
	
func to_save_data_arguments() -> GameSaveDataArguments: 
	return GameSaveDataArguments.new().set_overwrite(overwrite).set_save_name(save_data.name)
