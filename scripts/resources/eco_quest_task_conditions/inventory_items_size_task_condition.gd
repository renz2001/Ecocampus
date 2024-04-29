extends EcoQuestTaskScriptCondition
class_name InventoryItemsSizeTaskCondition


@export var items_size: int = 0

var player: PlayerNode: 
	get: 
		return PlayerManager.player


func _initialized() -> void: 
	if player.data.inventory.items.size() == 0: 
		counter.increment()
	player.data.inventory.items_changed.connect(_on_items_changed)


func _on_items_changed(items: Array[ItemStack]) -> void: 
	if player.data.inventory.items.size() == 0: 
		counter.increment()


func _finished() -> void: 
	player.data.inventory.items_changed.disconnect(_on_items_changed)
	
	
