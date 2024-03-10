extends NodeComponent

@export var node: Node
@export var resource: String


func _ready() -> void: 
	node.set(resource, node.get(resource).duplicate(true))
