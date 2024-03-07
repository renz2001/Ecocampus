## Save data is the data of the entire game 
## This is the data stored in the game
extends Resource
class_name GameSaveData

#var groups_to_save: Array[String] = [
	#"EntityNode", 
	#"Interactable"
#]

var name: StringName = "save_data"

var data: Dictionary = {}

var is_autosave: bool = false

# Used by SaveFile
static func create_from_existing_file(path: String) -> GameSaveData: 
	var file: FileAccess = FileAccess.open(path, FileAccess.READ)
	
	# Turns text data to variants
	var file_data: Dictionary = JSON.parse_string(file.get_as_text())
	
	var save_data: GameSaveData = GameSaveData.new()
	save_data.name = file_data["SaveName"]
	save_data.data = file_data
	file.close()
	return save_data


# TODO: Update this with the new SaveComponents! 
func save_game(scene_tree: SceneTree) -> void: 
	#if !scene_tree.current_scene is RoomNode: 
		#printerr("GameSaveData: Cannot save_game because the current_scene is not a RoomNode. ")
	# Will only set the save_file_created if the file does not already exist. 
	#if is_new(): 
		#GameData.save_file_created = DateTime.new(Time.get_datetime_dict_from_system())
	data["SaveName"] = name
	#data["GameData"] = {} 
	#data["GameData"] = GameData.save_data()
	#data["PlayerData"] = PlayerManager.save_data()
	#data["LevelChapters"] = {}
	#data["LevelChapters"][str(RoomManager.room.chapter_id)] = {}
	#
	#var chapter = data["LevelChapters"][str(RoomManager.room.chapter_id)]
	#chapter[str(RoomManager.room.level_id)] = {}
	#
	#var level = chapter[str(RoomManager.room.level_id)]
	#level[str(RoomManager.room.stage_id)] = {}
	#
	#var stage = level[str(RoomManager.room.stage_id)]
	#stage[str(RoomManager.room.room_id)] = {}
	#
	#var current_room_data = stage[str(RoomManager.room.room_id)]
	
	#for king_save: MasterSaveComponent in scene_tree.get_nodes_in_group("MasterSaveComponent"): 
		#data.merge(king_save.to_dict(), true)
	var king_save: KingSaveComponent = scene_tree.get_first_node_in_group("KingSaveComponent")
	#print(king_save.to_dict())
	data.merge(king_save.to_dict(), true)
	#for group in groups_to_save:
		#var nodes_in_group = scene_tree.get_nodes_in_group(group)
		#current_room_data[group] = {}
		#for node in nodes_in_group:
			#if node.is_in_group("PlayerNode"): 
				#continue
			#var node_data: Dictionary = node.save_data()
			#if group == "Interactable": 
				#current_room_data[group][node.get_path()] = node_data
				#continue
			#elif group == "EntityNode": 
				#current_room_data[group][node.id] = node_data
				#continue
			#current_room_data[group][node.get_path()] = node_data
	#current_room_data["RoomData"] = RoomManager.save_data()
	
	
func to_json() -> JSON: 
	var json: JSON = JSON.new()
	var error = json.parse(JSON.stringify(data))
	if error == OK:
		return json
	return null


#func is_new() -> bool: 
	#if SaveManager.does_save_file_name_already_exist(name): 
		#return false
	#return true
	
	
func is_empty() -> bool: 
	return data.is_empty()
	

