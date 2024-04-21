## SaveComponent used for gathering all the MasterComponents in a scene. There should only be one in a level scene. 
extends NodeComponent
class_name KingSaveComponent

@export var node: Node

@export var id_component: IDComponent


func to_dict() -> Dictionary: 
	
	var king_dict: Dictionary = {
		"Globals": {}
	}
	
	for master: MasterSaveComponent in get_tree().get_nodes_in_group("MasterSaveComponent"): 
		#print(masters.to_dict())
		if master.no_king: 
			king_dict["Globals"].merge(master.to_dict())
			continue
		king_dict.merge(master.to_dict())
		#print(masters.to_dict())
	for globals: GlobalsSaveComponent in get_tree().get_nodes_in_group("GlobalsSaveComponent"): 
		king_dict["Globals"].merge(globals.to_dict())
		
		
	var key: String = str(id_component.data.value)
	
	var dict: Dictionary = {
		key: king_dict
	}
	return dict
	
	
func load_data(data: Dictionary) -> void: 
	var king_dict = data[id_component.id.value]
	for path: String in king_dict.keys(): 
		var follower_save: FollowerSaveComponent = node.get_node(path)
		#follower_save.load_data()

