extends EcoQuestTaskScriptCondition
class_name AllTrashCansInventorySizeTaskCondition


@export var total_stack_size: int = 10

var trash_cans: Array[Node]: 
	get: 
		return tree.get_nodes_in_group("TrashCan")
		
		
func _initialized() -> void: 
	if !WorldEventManager.event_called.is_connected(_on_event_called): 
		WorldEventManager.event_called.connect(_on_event_called)
	initialized()
	

func initialized() -> void: 
	check()
	for can: TrashCanNode in trash_cans: 
		if !can.inventory.items_changed.is_connected(_on_items_changed): 
			can.inventory.items_changed.connect(_on_items_changed)


func _on_items_changed(_items: Array[ItemStack]) -> void: 
	check()


func condition() -> bool: 
	if trash_cans.is_empty(): 
		return false
	return trash_cans.all(
		func(can: TrashCanNode): 
			return can.inventory.get_total_stack() >= total_stack_size
	)

func check() -> void: 
	if condition(): 
		counter.increment()


func _finished() -> void: 
	for can: TrashCanNode in trash_cans: 
		if can.inventory.items_changed.is_connected(_on_items_changed): 
			can.inventory.items_changed.disconnect(_on_items_changed)


func _on_event_called(event: String, _by: Node, _args: Array) -> void: 
	if event == "ready": 
		initialized()
