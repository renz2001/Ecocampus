## Used by GameSave to save the node's data
extends NodeComponent
class_name FollowerSaveComponent

## The node to save the data from
@export var node: Node
@export var data: PropertiesToSave

func to_dict() -> Dictionary: 
	var dict: Dictionary = {
		str(get_path()): data.to_dict(node)
	}
	return dict
	
	
func load_dict(dict: Dictionary) -> void: 
	PropertiesToSave.load_dict_to_object(node, dict)
	
	
