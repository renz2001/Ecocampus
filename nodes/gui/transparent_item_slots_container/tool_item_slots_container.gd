@tool
extends HBoxContainer
class_name TransparentItemSlotsContainer


@export var inventory: Inventory: 
	set(value): 
		inventory = value
		update()
		if inventory == null: 
			return
			
		if !inventory.items_changed.is_connected(_on_inventory_items_changed): 
			inventory.items_changed.connect(_on_inventory_items_changed)
		
@export var item_slot_scene: PackedScene

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
	
	
func _on_dragging_cancelled() -> void: 
	update()
	
	
func _on_dropped() -> void: 
	update()
	
	
func update() -> void: 
	if !is_node_ready(): 
		await ready
		
	await get_tree().process_frame
	
	clear() 
	
	if !inventory: 
		return
		
	var items: Array[ItemStack] = inventory.get_items_by_type(ItemModel.Type.TOOL)
	for i: int in items.size(): 
		var item: ItemStack = items[i]
		var item_slot: ItemSlot = item_slot_scene.instantiate()
		add_child(item_slot)
		item_slot.item = item
		if i == 0 && items.size() != 1: 
			item_slot.border_state = TransparentItemSlot.BorderState.RIGHT
		elif i == items.size() - 1: 
			item_slot.border_state = TransparentItemSlot.BorderState.LEFT
		else: 
			item_slot.border_state = TransparentItemSlot.BorderState.BOTH
	
	
func clear() -> void: 
	for node: Node in get_children(): 
		node.queue_free.call_deferred()
