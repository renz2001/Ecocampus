extends EcoQuestTaskScriptConditionNode
class_name PickedUpItemsTaskConditionNode


func _initialized() -> void: 
	var player: PlayerNode = PlayerManager.player
	var items_amount: int = player.inventory.count_items_by_model(condition.picked_up_item)
	condition.counter.add(items_amount)
	player.inventory.items_added.connect(_on_items_added)


func _on_items_added(items: Array[ItemStack]) -> void: 
	for item_stack: ItemStack in items: 
		if item_stack.model == condition.picked_up_item: 
			condition.counter.add(item_stack.stack.current)
	
	
