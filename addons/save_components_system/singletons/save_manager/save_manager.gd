extends Node

signal saved_data(data: GameSave)
signal loaded_data(data: GameSave)

signal saved_data_to_file(data: GameSave, save_file: SaveFile)

signal save_file_removed( save_file: SaveFile)

signal save_files_edited(new_save_files: Array[SaveFile])

@export var print_color: PrintColor: 
	set(value): 
		print_color = value
		print_color.owner = self


## Path of the user://
var user_path: String = "user://"

## Name of the main folder of the game
var game_data_folder_path: String = user_path + "Ecocampus/" 

## Folder where saves are stored
var saves_folder_path: String = game_data_folder_path + "saves/" 

## Base Save File Name
var save_file_name: String = SaveFile.base_name + "_%s"

## File name for autosaves
var autosave_file_name: String = save_file_name % "%s_autosave"

# GameSave class is for loading in between levels and writing to file. 
# To load data from a save file, load data directly from the file, it is not turned into a GameSave object. 

var current_saved_data: GameSave = GameSave.new()

# Data Structure: 
# SaveName: GameSave name, 
# ID: {
#	"NodePath" : {
#		"PropertyName" : Value
#	}
# }


func _ready() -> void:
	# Creates a directory/folder in the specified location statically. 
	DirAccess.make_dir_absolute(game_data_folder_path)
	DirAccess.make_dir_absolute(saves_folder_path)


## Used to set the current_game_save from a file path. Then you can load the game file. 
func set_current_game_save_from_file_name(file_name: String) -> void: 
	await get_tree().process_frame
	var file: SaveFile = SaveFile.from_file(file_name)
	set_current_game_save_data(file.data)
	print_color.out_debug_wvalue("Set current game save from file name", file_name)


func set_current_game_save_data(save_data: GameSave) -> void: 
	current_saved_data = save_data


## Saves in game save data to computer
func save_game_to_file(overwrite: bool = false) -> SaveFile: 
	await get_tree().process_frame
	var save_file: SaveFile = SaveFile.create_from_save_data(current_saved_data, overwrite)
	saved_data_to_file.emit(current_saved_data, save_file.data.name)
	save_files_edited.emit(get_save_files())
	print_color.out_debug_wvalue("Saved Game to file", [current_saved_data.name, save_file.name])
	return save_file
	
	
# Stores it into current_save_data, as well as returns the data itself. 
## Saves game data in game to saved_datas
func save_game(new_name: String = "") -> void: 
	await get_tree().process_frame
	if !new_name.is_empty(): 
		current_saved_data.name = new_name
	current_saved_data.save_game(get_tree())
	
	saved_data.emit(current_saved_data)
	print_color.out_debug_wvalue("Saved Game", current_saved_data.name)

## current_id is the key for the save file/current KingSaveComponent/current level. 
func load_current_game_save(current_id: String) -> void: 
	await get_tree().process_frame
	current_saved_data.load_game(get_tree(), current_id)
	loaded_data.emit(current_saved_data)
	print_color.out_debug_wvalue("Loaded current game save", current_saved_data.name)
	
	
func get_indexed_string_from_array(val: String, array: Array, adjustment: int = 0) -> String: 
	var new: String = ""
	var index: int = array.size() + 1 + adjustment
	new = val + "_" + str(index)
	return new


func get_non_numbered_string(val: String) -> String: 
	var split: PackedStringArray = val.split("_")
	var res: String = ""
	for i in split: 
		if i.is_valid_int(): 
			continue
		res += i
	return res


func remove_save_file(save_file: GameSave) -> void: 
	save_file_removed.emit(save_file)
	save_files_edited.emit(get_save_files())


func does_save_file_name_exists(file_name: String) -> bool: 
	var saves_folder_dir: DirAccess = DirAccess.open(saves_folder_path)
	return saves_folder_dir.file_exists(file_name + ".json")
	
	
func save_files_is_empty() -> bool:
	return get_save_files().is_empty()


func get_save_files() -> Array[SaveFile]: 
	var save_files: Array[SaveFile] = []
	#
	for file in DirAccess.get_files_at(saves_folder_path): 
		var file_name: String = get_file_name(file, false)
		#print(get_file_name(file, false))
		#print(file_name.begins_with(save_file_name % ""))
		if !file_name.begins_with(save_file_name % ""):
			continue
		var save_file: SaveFile = get_save_file(file_name)
		save_files.append(save_file)
	return save_files 


# Gets the name of the file, or the last name in the directory. 
func get_file_name(file_path: String, with_extension: bool = true) -> String: 
	var last_dir: int = file_path.count("/")
	var split: PackedStringArray = file_path.split("/")
	var file_name: String = split[last_dir]
	if !with_extension: 
		file_name = file_name.split(".")[0]
	return file_name 


func get_save_file(file_name: String) -> SaveFile: 
	return SaveFile.from_file(file_name)


# WIP
func get_most_recent_save_file() -> SaveFile: 
	var maxxed_file: String
	for save_file in get_save_files(): 
		var file_path: String = save_file.file_path
		if FileAccess.get_modified_time(file_path) > FileAccess.get_modified_time(maxxed_file): 
			maxxed_file = file_path
	@warning_ignore("unassigned_variable")
	var most_recent_save_file: SaveFile
	return most_recent_save_file
