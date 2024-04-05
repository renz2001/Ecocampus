extends OnInteractComponent
class_name OnInteractPickup


func _on_interact() -> void: 
	var player: PlayerNode = get_tree().get_first_node_in_group("Player") 
	player.inventory.take_from_inventory(entity.inventory)
	entity.queue_free()

