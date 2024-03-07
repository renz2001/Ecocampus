extends Resource
class_name WorldEventCall

@export var event: String
@export var one_shot: bool


static func from_world_event(world_event: WorldEvent) -> WorldEventCall: 
	var event_call: WorldEventCall = WorldEventCall.new()
	event_call.event = world_event.id
	event_call.one_shot = world_event.only_called_once
	return event_call


func set_event(val: String) -> WorldEventCall: 
	event = val
	return self


func set_one_shot(val: bool) -> WorldEventCall: 
	one_shot = val
	return self
	
	
