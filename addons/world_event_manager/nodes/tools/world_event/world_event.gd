@icon("res://addons/world_event_manager/class_icons/world-event.png")
@tool
extends Node
class_name WorldEvent

signal event_called(called_by: Node)

@export var only_called_once: bool = true
@export var disabled: bool = false

@export_group("Call event script")
## The method from the node to be called, func(called_by: Node, args: Array = []) 
@export var call_node_method: String = "world_event_call"

## Node attached with a script to be called
@export var call_node: Node


@export_group("Dependencies")
@export var times_called: PointCounterComponent

var id: String:
	get:
		return name.to_snake_case()

func is_id(event: String) -> bool: 
	return id == event.to_snake_case()


func call_event(called_by: Node, args: Array = []) -> void: 
	if disabled: 
		return
	#call_event_components()
	if call_node: 
		call_node.call(call_node_method, args)
	_call_event(called_by)
	times_called.points.increment() 
	if only_called_once:
		disabled = true
	event_called.emit(called_by)


## @deprecated 
func _call_event(_called_by: Node) -> void:
	pass

	
	
