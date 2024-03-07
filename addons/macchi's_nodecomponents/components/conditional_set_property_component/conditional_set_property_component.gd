extends ConditionalSetComponent
class_name ConditionalSetPropertyComponent

@export var ready_value: String
@export var node: Node
@export var property_or_method: String
@export var new_value: String


func _ready() -> void: 
	if !node.is_node_ready(): 
		await node.ready
	node.set(property_or_method, str_to_var(ready_value))


func _condition_met() -> void: 
	node.set(property_or_method, str_to_var(new_value))
	
	
