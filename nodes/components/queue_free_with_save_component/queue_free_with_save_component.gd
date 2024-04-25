extends NodeComponent
class_name QueueFreeWithSaveComponent

@export var node: Node

func use() -> void: 
	node.master_save_component
	node.queue_free()
