extends Node

@export var player: String = "Player"

func get_first_node(group_name: String) -> Node: 
	return get_tree().get_first_node_in_group(group_name)
	
	
func get_nodes(group_name: String) -> Array[Node]: 
	return get_tree().get_nodes_in_group(group_name)
	
	
