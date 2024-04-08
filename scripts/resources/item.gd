## Item resource that contains modifiable properties and contains ItemModel. 
extends SaveableResource
class_name Item

@export var model: ItemModel: 
	set(value): 
		model = value
		stack = model.stack.duplicate(true)

var stack: PointCounter
