@tool
extends NodeComponent
class_name IDComponent

@export var node: Node

## If left null, it will generate a random ID. 
@export var data: ID: 
	set(value): 
		data = value
		if Engine.is_editor_hint(): 
			return
		if !node.is_node_ready(): 
			await node.ready
			
		if data == null: 
			data = ID.create() 
		node.name = str(data.value)
