extends Node
class_name AchievementsTracker




func _on_global_data_player_instanced(player: PlayerNode) -> void:
	player.inventory.items_changed.connect(_on_player_inventory_items_changed)
	
	
func _on_player_inventory_items_changed(previous_items: Array[Item], new_items: Array[Item], changed_by: Node) -> void: 
	var player: PlayerNode = GroupNodeFetcher.get_player()
	
	
	
