extends ConditionalSetComponent
class_name ConditionalSetResourcePropertyComponent

@export var dont_ready_value: bool = true
## Property or method's new value when the node is ready. 
@export var ready_value: Resource
@export var node: Node

## Property or method (method's return value) to be set with a new value. 
@export var property_or_method: String

## Property or method's new value when the condition is met.
@export var new_value: Resource

func _ready() -> void: 
	if disabled: 
		return
	if !node.is_node_ready(): 
		await node.ready
	if dont_ready_value: 
		return
	node.set(property_or_method, ready_value)


func _condition_met() -> void: 
	node.set(property_or_method, new_value)
	
