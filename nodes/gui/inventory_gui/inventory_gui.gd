extends GUI
class_name InventoryGUI

@export var item_slots: HBoxContainer
@export var inventory: Inventory


# TODO
func load_items(inv: Inventory) -> void: 
	inventory = inv
	
	
	
