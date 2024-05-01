extends ConditionalSetComponent
class_name ConditionalSetPropertyComponent

@export var dont_ready_value: bool
## Property or method's new value when the node is ready. 
@export var ready_value: String
@export var node: Node

## Property or method (method's return value) to be set with a new value. 
@export var property_or_method: String

## Property or method's new value when the condition is met.
@export var new_value: String


func _ready() -> void: 
	if disabled: 
		return
	if !node.is_node_ready(): 
		await node.ready
	if dont_ready_value: 
		return
	node.set(property_or_method, str_to_var(ready_value))


func _condition_met() -> void: 
	node.set(property_or_method, str_to_var(new_value))
	
