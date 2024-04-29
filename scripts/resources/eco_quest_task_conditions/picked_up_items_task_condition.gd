extends EcoQuestTaskScriptCondition
class_name PickedUpItemsTaskCondition


@export var picked_up_item: ItemModel

var player: PlayerNode: 
	get: 
		return PlayerManager.player

func _initialized() -> void: 
	var items_amount: int = player.data.inventory.count_item_by_model(picked_up_item)
	counter.add(items_amount)
	player.data.inventory.items_added.connect(_on_items_added)


func _on_items_added(items: Array[ItemStack]) -> void: 
	for item_stack: ItemStack in items: 
		if item_stack.model == picked_up_item: 
			counter.add(item_stack.stack.current)


func _finished() -> void: 
	if player.data.inventory.items_added.is_connected(_on_items_added): 
		player.data.inventory.items_added.disconnect(_on_items_added)
	
	
