extends NodeComponent
class_name QueueFreeWithSaveComponent

@export var node: Node

func use() -> void: 
	node.queue_free()
	node.master_save_component.is_queued_free = true
	SaveManager.save_game()

