@tool
extends GUI
class_name InventoryGUI

@export var item_slots: HBoxContainer
@export var inventory: Inventory: 
	set(value): 
		inventory = value
		if !is_node_ready(): 
			await ready
		if inventory: 
			if !inventory.items_changed.is_connected(_on_inventory_items_changed): 
				inventory.items_changed.connect(_on_inventory_items_changed)
			var children: Array[Node] = item_slots.get_children()
			for i: int in children.size(): 
				var slot: ItemSlot = children[i]
				slot.item = null
				if i < inventory.items.size(): 
					slot.item = inventory.items[i]


func _ready() -> void: 
	if Engine.is_editor_hint(): 
		return
	PlayerManager.player_instanced.connect(_on_player_instanced)


func _on_player_instanced() -> void: 
	inventory = PlayerManager.player.inventory
	
	
func _on_inventory_items_changed(new_items: Array[Item]) -> void: 
	inventory = PlayerManager.player.inventory
