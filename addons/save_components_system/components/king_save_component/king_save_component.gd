## SaveComponent used for gathering all the MasterComponents in a scene. There should only be one in a level scene. 
extends NodeComponent
class_name KingSaveComponent

@export var node: Node

@export var id_component: IDComponent


func to_dict() -> Dictionary: 
	
	var king_dict: Dictionary = {
	
	}
	
	var dict: Dictionary = {}
	
	await get_tree().process_frame
	for master: MasterSaveComponent in get_tree().get_nodes_in_group("MasterSaveComponent"): 
		#print(masters.to_dict())
		if master.no_king: 
			SaveManager.current_saved_data.data["Globals"].merge(master.to_dict())
			continue
		
		# FIXME: BandAid solution
		if master.is_queued_free: 
			var queued_frees: Array = SaveManager.current_saved_data.data["QueuedFree"]
			queued_frees.append(master.node.get_path())
			
		king_dict.merge(master.to_dict())
		
		#await get_tree().process_frame
		#printerr("king: ", king_dict[master.get_path()]["is_queued_free"])
		#print(masters.to_dict())
	for globals: GlobalsSaveComponent in get_tree().get_nodes_in_group("GlobalsSaveComponent"): 
		SaveManager.current_saved_data.data["Globals"].merge(globals.to_dict())
		await get_tree().process_frame
		
	var key: String = str(id_component.data.value)
	#printerr(SaveManager.current_saved_data.data["QueuedFree"])
	
	await get_tree().process_frame
	dict[key] = king_dict
	return dict
	
	
func load_data(data: Dictionary) -> void: 
	var king_dict = data[id_component.id.value]
	for path: String in king_dict.keys(): 
		var follower_save: FollowerSaveComponent = node.get_node(path)
		#follower_save.load_data()

