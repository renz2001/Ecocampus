extends NodeComponent
class_name ReadyUniqueResource

signal resource_ready

@export var node: Node
@export var resource: String

## Use a method from the resource to duplicate. Leave this empty if you don't want to use it. 
@export var duplicate_from_method: String
@export var disabled: bool

func _ready() -> void: 
	if disabled: 
		return
		
	if !duplicate_from_method.is_empty(): 
		#printerr(owner)
		#printerr(node)
		#printerr(resource)
		node.set(resource, Callable(node.get(resource), duplicate_from_method).call())
	else: 
		node.set(resource, node.get(resource).duplicate(true))
	
	#print(node, node.get(resource))
	resource_ready.emit()
