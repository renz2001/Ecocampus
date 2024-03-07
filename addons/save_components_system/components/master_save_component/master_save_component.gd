## Master means it is an owner of multiple SaveComponents 
extends FollowerSaveComponent
class_name MasterSaveComponent

@export var id: IDComponent: 
	set(value): 
		id = value
@export var do_not_search_nodes: PackedStringArray

func _ready() -> void: 
	if !node.is_node_ready(): 
		await node.ready
	#node.add_to_group("MasterSaveNode")


func to_dict() -> Dictionary: 
	var follower_dicts: Dictionary = {}
	
	for save: FollowerSaveComponent in _get_all_save_components(node): 
		#print(path)
		follower_dicts.merge(save.to_dict()) 
		
	#print("\nfollower dict: %s\n" % follower_dicts)
	var key: String = get_path()
	#print(node.get_path())
	var master_dict: Dictionary = {}
	
	if data != null: 
		master_dict[key] = data.to_dict(node)
	
	#if id.data != null: 
		#master_dict.merge({
			#"id": id.data.value
		#})
	
	master_dict.merge(follower_dicts)
	#print("\nmaster_dict: %s\n" % master_dict)
	return master_dict

# {
#  node_path: { all properties }, 
#  merged_data: { props }
# }

func _get_all_save_components(parent: Node) -> Array[FollowerSaveComponent]: 
	var save_components_in_node: Array[FollowerSaveComponent] = []
	for child: Node in parent.get_children(): 
		if child.name in do_not_search_nodes: 
			continue
		if child is FollowerSaveComponent && !child is MasterSaveComponent: 
			save_components_in_node.append(child)
		elif child.get_child_count() > 0: 
			save_components_in_node.append_array(_get_all_save_components(child))
	return save_components_in_node


#func load_dict(master_dict: Dictionary) -> void: 
	##super.load_dict(dict)
	#for master_property: String in master_dict.keys(): 
		#if master_property == "follower_saves": 
			#var follower_dict: Dictionary = master_dict[master_property]
			#for follower_node_path: String in follower_dict: 
				#var follower_save: FollowerSaveComponent = get_node(follower_node_path)
				#var follower_data: Dictionary =  follower_dict[follower_node_path]
				#follower_save.load_dict(follower_data) 
			#continue
		#var master_value = str(master_dict[master_property])
		#node.set(master_property, master_value)

