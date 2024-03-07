extends NodeComponent


@export var node: Node
@export var id: ID


func to_dict() -> Dictionary: 
	var dict: Dictionary = {}
	for masters: MasterSaveComponent in get_tree().get_nodes_in_group("FollowerSaveComponent"): 
		dict.merge(masters.to_dict(), true)
	return dict
	
	
func load_data() -> void: 
	pass
	
	
