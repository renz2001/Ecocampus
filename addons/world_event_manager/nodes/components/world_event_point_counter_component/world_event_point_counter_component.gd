@icon("res://addons/world_event_manager/class_icons/event-point-counter.png")
extends PointCounterComponent
class_name EventWorldPointCounterComponent

## Calls 
@export var call_event_from_signal: String: 
	set(value): 
		if !is_node_ready(): 
			await ready
		call_event_from_signal = value
		call_world_event_from_signal.from_signal = call_event_from_signal
		
## Increments when event is heard. 
@export var event_call: WorldEventCall: 
	set(value): 
		event_call = value


@export_group("Dependencies")
@export var world_event_listener: WorldEventListenerComponent
@export var call_world_event_from_signal: CallWorldEventFromSignalComponent


func _on_world_event_listener_event_called() -> void:
	points.increment()

