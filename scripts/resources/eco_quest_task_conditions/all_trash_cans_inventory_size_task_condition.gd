extends EcoQuestTaskScriptCondition
class_name AllTrashCansInventorySizeTaskCondition


@export var items_size: int = 10

var trash_cans: Array[Node]: 
	get: 
		return tree.get_nodes_in_group("TrashCan")


func _initialized() -> void: 
	check()
	for can: TrashCanNode in trash_cans: 
		can.inventory.items_changed.connect(_on_items_changed)


func _on_items_changed(_items: Array[ItemStack]) -> void: 
	check()


func condition() -> bool: 
	if trash_cans.is_empty(): 
		return false
	return trash_cans.all(
		func(can: TrashCanNode): 
			return can.inventory.items.size() == items_size
	)

func check() -> void: 
	if condition(): 
		counter.increment()


func _finished() -> void: 
	for can: TrashCanNode in trash_cans: 
		can.inventory.items_changed.disconnect(_on_items_changed)

