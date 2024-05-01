@tool
extends GUI
class_name InventoryGUI

signal updated

@export var item_slots: HBoxContainer
@export var inventory: Inventory: 
	set(value): 
		inventory = value
		if !is_node_ready(): 
			await ready
			
		update()
		if inventory == null: 
			return
			
		if !inventory.items_changed.is_connected(_on_inventory_items_changed): 
			inventory.items_changed.connect(_on_inventory_items_changed)

var updating: bool

static func this() -> InventoryGUI: 
	return GameManager.get_tree().get_first_node_in_group("InventoryGUI")


func _ready() -> void: 
	if Engine.is_editor_hint(): 
		return
	PlayerManager.player_instanced.connect(_on_player_instanced)
	MouseDrag.dragging_cancelled.connect(_on_dragging_cancelled)
	MouseDrag.dropped.connect(_on_dropped)
	

func _on_player_instanced() -> void: 
	update()
	
	
func _on_inventory_items_changed(_new_items: Array[ItemStack]) -> void: 
	update()


func update() -> void: 
	var children: Array[Node] = item_slots.get_children()
	for i: int in children.size(): 
		var _slot: ItemSlot = children[i]
		
		_slot.item = null
		
	if inventory == null || inventory.items.is_empty(): 
		return
	
	if updating: 
		return
	updating = true
	
	var inv_items_size: int = inventory.items.size()
	
	for i: int in children.size(): 
		var slot: ItemSlot = children[i]
		if i >= inv_items_size: 
			break
		slot.item = inventory.items[i]
		#printerr(inventory.items)
	updating = false
	
func _on_dragging_cancelled() -> void: 
	update()
	
	
func _on_dropped() -> void: 
	update()

