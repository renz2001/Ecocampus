extends NodeComponent
class_name KingSaveComponent

@export var node: Node

@export var id: ID: 
	set(value): 
		#if Engine.is_editor_hint(): 
			#return
		id = value
		if !is_node_ready(): 
			await ready
		id_component.data = id

@export var id_component: IDComponent


func to_dict() -> Dictionary: 
	
	var king_dict: Dictionary = {}
	
	for masters: MasterSaveComponent in get_tree().get_nodes_in_group("MasterSaveComponent"): 
		#print(masters.to_dict())
		king_dict.merge(masters.to_dict())
		#print(masters.to_dict())
		
	var dict: Dictionary = {
		str(id_component.data.value): king_dict
	}
	return dict
	
	
func load_data(data: Dictionary) -> void: 
	var grand_master_dict = data[id.value]
	for path: String in data[id.value].keys(): 
		var follower_save: FollowerSaveComponent = node.get_node(path)
		#follower_save.load_data()
	
	
