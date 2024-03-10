@tool
## To be used by NodeVarietyManager
## The name of this node is the variety name. 
extends NodeComponent
class_name NodeVariety 

@export var active: bool: 
	set(value): 
		active = value
		if !is_node_ready() && !Engine.is_editor_hint(): 
			await ready 
		NodeTools.disable_nodes(nodes, active)
		
		
@export var nodes: Array[Node]
