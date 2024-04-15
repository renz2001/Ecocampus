## This is the data stored in the machine. 
extends Resource
class_name SaveFile 

static var extension: String = ".json" 

static var base_name: String = "save_file"

var name: String

var data: GameSave
# Just the file name with the extension


## Automatically creates a file in the computer
static func create_from_save_data(save_data: GameSave, overwrite: bool = false, create_new_if_it_doesnt_exist_with_overwrite_on: bool = true) -> SaveFile: 
	var save_file: SaveFile = SaveFile.new()
	
	var current_save_files: Array[SaveFile] = SaveManager.get_save_files()
	
	save_file.name = SaveManager.get_indexed_string_from_array(SaveFile.base_name, current_save_files, -1)
	
	# If save file already exists. 
	if save_file.file_exists(): 
		if overwrite: 
			save_file = SaveFile.from_file(save_file.name)
			save_file.data.data.merge(save_data.data, true)
			
			_create_file(save_file.name, save_file.data.data)
		elif overwrite == false: 
			push_warning("File exists but overwrite is false")
			return null
		elif overwrite == false && create_new_if_it_doesnt_exist_with_overwrite_on: 
			save_file.name = SaveManager.get_indexed_string_from_array(SaveFile.base_name, current_save_files)
			save_file.data = save_data
			_create_file(save_file.name, save_data.data)
	else: 
		save_file.name = SaveManager.get_indexed_string_from_array(SaveFile.base_name, current_save_files)
		 #If save file does not exist and not overwrite
		save_file.data = save_data
		_create_file(save_file.name, save_data.data)
		
	return save_file


## For getting file from computer. file_name not file_path
static func from_file(file_name: String ) -> SaveFile:
	#file_name = _file_name
	#make_file = _make_file
	var save_file: SaveFile = SaveFile.new()
	var path: String = SaveManager.saves_folder_path + file_name + extension
	
	if ResourceLoader.exists(path): 
		save_file.name = file_name
		save_file.data = GameSave.create_from_existing_file(path)
		return save_file
		
	push_error("Save file: %s does not exist in Directory. " % path)
	return null


static func _create_file(name: String, data: Dictionary) -> void: 
	#FileAccess.open(to_file_name_with_path(), FileAccess.WRITE)
	var _file: FileAccess = FileAccess.open(SaveManager.saves_folder_path + name + extension, FileAccess.WRITE)
	_file.store_string(JSON.stringify(data))
	_file.close()
	
	
func file_exists() -> bool: 
	#print(to_file_name_with_path_and_extension())
	#print(ResourceLoader.exists(to_file_name_with_path_and_extension()))
	return ResourceLoader.exists(to_file_name_with_path_and_extension())


func to_file_name_with_path_and_extension() -> String: 
	return to_file_name_with_path() + extension


func to_file_name_with_path() -> String: 
	return SaveManager.saves_folder_path + name


func get_file_access(access: FileAccess.ModeFlags) -> FileAccess: 
	return FileAccess.open(to_file_name_with_path_and_extension(), access)
	
	
