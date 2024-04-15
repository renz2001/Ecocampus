extends OnInteractComponent
class_name OnInteractPickup

@export var use_first_item_as_argument_for_event: bool = true
@export var call_world_event_component: CallWorldEventComponent


func _on_interact() -> void: 
	var player: PlayerNode = get_tree().get_first_node_in_group("Player") 
	
	player.inventory.items_added.connect(_on_items_added, CONNECT_ONE_SHOT)
	player.inventory.take_inventory(entity.inventory, player)
	entity.queue_free()


func _on_items_added(items: Array[ItemStack]) -> void:  
	var event_call: WorldEventCall = WorldEventCall.new().set_event("picked_up")
	if use_first_item_as_argument_for_event: 
		event_call.set_arguments([items[0].model.name.to_snake_case()])
	
	call_world_event_component.event_call = event_call
	call_world_event_component.node = entity
	call_world_event_component.play()

