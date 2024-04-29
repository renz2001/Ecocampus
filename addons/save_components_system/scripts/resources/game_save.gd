## Save data is the data of the entire game 
## This is the data stored in the game
extends Resource
class_name GameSave

var name: StringName = "save_data"

var data: Dictionary = {
	"QueuedFree": [], 
	"Globals": {}
}

var is_autosave: bool = false

# Used by SaveFile
static func create_from_existing_file(path: String) -> GameSave: 
	var file: FileAccess = FileAccess.open(path, FileAccess.READ)
	
	# Turns text data to variants
	var file_data: Dictionary = JSON.parse_string(file.get_as_text())
	#printerr("SAVE: ", file_data)
	var save_data: GameSave = GameSave.new()
	save_data.name = file_data["SaveName"]
	save_data.data = file_data
	file.close()
	return save_data


func save_game(scene_tree: SceneTree) -> void: 
	data["SaveName"] = name
	for king_save: KingSaveComponent in scene_tree.get_nodes_in_group("KingSaveComponent"): 
		data.merge(await king_save.to_dict())
		
	
func load_game(scene_tree: SceneTree, current_id: String) -> void: 
	if !data.has(current_id): 
		return
	var data_group: Dictionary = data[current_id]
	
	for key: String in data_group.keys(): 
		if scene_tree.current_scene.has_node(key): 
			var follower_node: FollowerSaveComponent = scene_tree.current_scene.get_node(key)
			var load_data: Dictionary = data_group[key]
			follower_node.load_dict(load_data)
			
	for key: String in data.keys(): 
		if key == "Globals": 
			for path: String in data[key]: 
				var follower_node: FollowerSaveComponent = scene_tree.current_scene.get_node(path)
				var load_data: Dictionary = data[key][path]
				follower_node.load_dict(load_data)
				
				
	for path: String in data["QueuedFree"]: 
		if scene_tree.current_scene.has_node(path): 
			scene_tree.current_scene.get_node(path).queue_free()
			
			
func to_json() -> JSON: 
	var json: JSON = JSON.new()
	var error = json.parse(JSON.stringify(data))
	if error == OK:
		return json
	return null


#func is_new() -> bool: 
	#if SaveManager.does_save_file_name_exists(name): 
		#return false
	#return true
	
	
func is_empty() -> bool: 
	return data.is_empty()
	

