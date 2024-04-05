@icon("res://addons/world_event_manager/class_icons/world-event-listener.png")
## Listens for a specific event, then emits event_called. Meant for other nodes to use by being connected to this event. 
extends NodeComponent
class_name WorldEventListenerComponent

@export var event_listener: WorldEventListener


func set_properties(props: WorldEventCall) -> void: 
	event_listener.event = props.event
	event_listener.listen_once = props.one_shot
	
	
