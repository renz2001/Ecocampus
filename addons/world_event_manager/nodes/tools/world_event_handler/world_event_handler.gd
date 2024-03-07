@icon("res://addons/world_event_manager/class_icons/world-event-handler.png")
extends Node
class_name WorldEventHandler 

@export var generic_events: Node
@export var specific_events: Node
@export var task_events: Node
@export var _print_color: PrintColor

var local_events_history: Array[WorldEvent]


func get_events() -> Array[WorldEvent]: 
	return get_tree().get_nodes_in_group("WorldEvent") as Array[WorldEvent]


func call_event(event_name: String, called_by: Node, args: Array = []) -> void: 
	if event_name == "": 
		return
	var world_event: WorldEvent = get_world_event_node(event_name)
	world_event.call_event(called_by, args)
	_print_color.out_debug("Event Called: %s by: %s" % [world_event.id, called_by])
	local_events_history.append(world_event)


func get_world_event_node(event_name: String) -> WorldEvent: 
	event_name = event_name.to_pascal_case()
	if task_events.has_node(event_name): 
		return task_events.get_node(event_name)
		
	if generic_events.has_node(event_name): 
		return generic_events.get_node(event_name)
		
	if specific_events.has_node(event_name): 
		return specific_events.get_node(event_name)
	push_error("Error: WorldEvent: %s, cannot be found in WorldEventHandler. " % event_name)
	return null


func has_called_event(event_name: String) -> bool:
	for event: WorldEvent in local_events_history:
		if event.is_id(event_name): 
			return true
	return false
	
	
