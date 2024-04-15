extends NodeComponent
class_name IDComponent

@export var node: Node

## If left null, it will generate a random ID. 
@export var data: ID: 
	set(value): 
		data = value
		if !is_node_ready(): 
			await ready
			
		if !node.is_node_ready(): 
			await node.ready
			
		if !is_instance_valid(data): 
			data = ID.use_custom_id(node.get_path())
		else: 
			if Engine.is_editor_hint(): 
				return
			node.name = data.value
