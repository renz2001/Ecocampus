extends EntityNode
class_name ItemNode


func _interact() -> void: 
	var player: PlayerNode = get_tree().get_first_node_in_group("Player") 
	player.inventory.add_items(inventory.take_all_items(player))
	
	
