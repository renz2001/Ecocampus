extends Node

signal initialized

# WorldEventManager is for calling event scripts that only activate once
# StateMachine is for scipts that describe the current state of the game, they can also run more than once and it is the main script of the scene like a _ready() function

# WorldEventManager is below RoomManager
signal event_called(event: WorldEvent, called_by: Node, args: Array)


var world_event_handler: WorldEventHandler: 
	get: 
		return get_tree().get_first_node_in_group("WorldEventHandler")


var global_events_history: PackedStringArray = []


#func _init() -> void: 
	#RoomManager.room_is_ready.connect(_on_room_is_ready)
#
#
#func _on_room_is_ready(room: RoomNode) -> void: 
	#init(room)
	#
	#
#func init(room: RoomNode) -> void: 
	#world_event_handler = room.world_event_handler
	#initialized.emit()


# It is called call_event because you need to create a world event node in the world event handler
func call_event(event_name: String, called_by: Node, args: Array = []) -> void: 
	if event_name == "": 
		return
	world_event_handler.call_event(event_name, called_by, args)
	var world_event: WorldEvent = world_event_handler.get_world_event_node(event_name)
	global_events_history.append(world_event.id)
	event_called.emit(event_name, called_by, args)


func has_called_event(event_name: String) -> bool: 
	for event: String in global_events_history: 
		if event == event_name.to_snake_case(): 
			#printerr(event)
			#printerr(event_name)
			#printerr(" ")
			return true
	return false


