## Used by GameSaveData to save the node's data
extends NodeComponent
class_name FollowerSaveComponent

## The node to save the data from
@export var node: Node
@export var data: PropertiesToSave

# TODO: Implement a way to save custom resources

# {
#  get_path(): _data_to_dict()
# }

func to_dict() -> Dictionary: 
	var dict: Dictionary = {
		str(get_path()): data.to_dict(node)
	}
	return dict
	
	
func load_dict(dict: Dictionary) -> void: 
	# FIXME: Unfinished 
	for property: String in dict.keys(): 
		
		var value = dict[property]
		if value is String: 
			node.set(property, str_to_var(value))
		if value is Dictionary: 
			for value_prop: String in value.keys(): 
				var value_value = value[value_prop]
				node.set(value_prop, value_value)
		else: 
			#print(node.get(property))
			node.set(property, value)
			#printerr(node.get(property))
	
	
