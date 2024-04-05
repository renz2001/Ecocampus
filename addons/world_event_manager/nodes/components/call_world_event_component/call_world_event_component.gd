@icon("res://addons/world_event_manager/class_icons/call-world-event.png")
extends NodeComponent
class_name CallWorldEventComponent

## Owner of the event
@export var node: Node
@export var event_call: WorldEventCall
## For debug purposes 
@export var disabled: bool


func play() -> void: 
	if disabled: 
		return
	if event_call == null: 
		return
	if event_call.one_shot: 
		disabled = true
	WorldEventManager.call_event(event_call.event, node)
	
	
