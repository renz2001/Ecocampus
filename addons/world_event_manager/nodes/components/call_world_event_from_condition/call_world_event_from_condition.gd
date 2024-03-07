## Calls an event if a condition is met. 
## This has to be the child so that it is easier to read. 
@tool
extends ConditionalSetComponent
class_name CallEventFromCondition


@export var world_event: WorldEvent: 
	set(value): 
		world_event = value
		if Engine.is_editor_hint():
			return
		if !is_node_ready(): 
			await ready
		if world_event: 
			_call_event.event_call = WorldEventCall.from_world_event(world_event)

@export_group("Dependencies") 
@export var _call_event: CallWorldEventComponent
@export var _print_color: PrintColor


func _on_ready_event_listener_event_called(_event: WorldEvent, _by: Node, _args: Array) -> void:
	update_condition()
	
	
func _condition_met() -> void: 
	_call_event.play()
	_print_color.out_debug("condition fulfilled, called event: %s" % [world_event])
	
	
func _get_configuration_warnings() -> PackedStringArray: 
	var warnings = []
	if !is_instance_valid(world_event): 
		warnings.append("Set up the world event to be called. ")
	return warnings




