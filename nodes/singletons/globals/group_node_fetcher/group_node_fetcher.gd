extends Node

@export var player: String = "Player"

func get_first_node(group_name: String) -> Node: 
	return get_tree().get_first_node_in_group(group_name)
	
	
func get_nodes(group_name: String) -> Array[Node]: 
	return get_tree().get_nodes_in_group(group_name)
	
	
## Map: Callable(node) -> bool, If true, add it as a part of what is returned. 
func map_get_nodes(group_name: String, map: Callable) -> Array[Node]: 
	var nodes: Array[Node] = []
	for node: Node in get_tree().get_nodes_in_group(group_name): 
		if map.call(node): 
			nodes.append(node)
	return nodes
	
	
func get_player() -> PlayerNode: 
	return get_tree().get_first_node_in_group(player)
	
	
