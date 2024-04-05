@tool
extends NodeComponent
class_name CallWorldEventFromWorldEventComponent

## Owner of the event
@export var from_world_event: WorldEvent: 
	set(value): 
		from_world_event = value
		listener.event = from_world_event.id
@export var to_world_event: WorldEvent
## For debug purposes 
@export var disabled: bool
@export var one_shot: bool = false

@export_group("Dependencies")
@export var listener: WorldEventListenerComponent


func _on_world_event_listener_event_called() -> void:
	play() 
	
	
func play() -> void: 
	if disabled: 
		return
	if one_shot: 
		disabled = true
	if !is_instance_valid(to_world_event): 
		return
	WorldEventManager.call_event(to_world_event.id, from_world_event)



