extends GUI
class_name InventoryGUI

@export var item_slots: HBoxContainer
@export var inventory: Inventory

# TODO
func load_items(inv: Inventory) -> void: 
	inventory = inv
	var children: Array[Node] = item_slots.get_children()
	for i: int in children.size(): 
		var slot: ItemSlot = children[i]
		slot.item = inventory.items[i]
	
	
