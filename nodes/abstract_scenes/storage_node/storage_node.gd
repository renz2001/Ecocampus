extends EntityNode
class_name StorageNode


func _on_mouse_drag_drop_area_dropped(drag_data: Dictionary) -> void: 
	var item: ItemStack = drag_data["item"]
	var from_inventory: Inventory = item.owner
	
	inventory.take_item_from_inventory(from_inventory, item, self)


func mouse_drag_can_drop_condition() -> bool: 
	return _mouse_drag_can_drop_condition()
	
	
func _mouse_drag_can_drop_condition() -> bool: 
	return true
	
