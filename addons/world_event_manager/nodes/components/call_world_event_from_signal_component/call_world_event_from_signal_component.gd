@icon("res://addons/world_event_manager/class_icons/call-world-event-from-signal.png")
extends CallWorldEventComponent
class_name CallWorldEventFromSignalComponent

@export var from_signal: String
## If empty, then it takes the node's signal, but if from variable, then it take's the node's variable's signal (i.e. variable that references a resource or node or other object) 
@export var from_variable: String
@export var connect_flag: ConnectFlags


func _ready() -> void: 
	var target: Object = node
	if !from_variable.is_empty(): 
		target = node.get(from_variable)
	if target.has_signal(from_signal): 
		target.connect(from_signal, play, connect_flag)
	
	
	
