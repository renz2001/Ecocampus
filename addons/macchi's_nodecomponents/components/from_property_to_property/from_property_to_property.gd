extends NodeComponent


@export var from_property: String
@export var from_node: Node
@export var to_property: String
@export var to_node: Node


func _ready() -> void: 
	update()
	
	
func update() -> void: 
	if !from_node.is_node_ready(): 
		await from_node.ready
	if !to_node.is_node_ready(): 
		await to_node.ready
	to_node.set(to_property, from_node.get(from_property))
	#printerr(to_node.get(to_property))
	#printerr(from_node.get(from_property))
	#printerr(from_node.get("character_body"))

