@tool
extends HBoxContainer
class_name TransparentItemSlotsContainer


@export var inventory: Inventory: 
	set(value): 
		inventory = value
@export var item_slot_scene: PackedScene


func update() -> void: 
	if !is_node_ready(): 
		await ready
	clear() 
	for item: ItemStack in inventory.get_items_by_type(ItemModel.Type.TOOL): 
		var item_slot: ItemSlot = item_slot_scene.instantiate()
		add_child(item_slot)
		item_slot.item = item
	
	
func clear() -> void: 
	for node: Node in get_children(): 
		node.queue_free()
	
