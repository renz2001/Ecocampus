extends NodeComponent
class_name QueueFreeWithSaveComponent

@export var node: Node

func use() -> void: 
	var queued_frees: Array = SaveManager.current_saved_data.data["QueuedFree"]
	queued_frees.append(node.get_path())
	
	SaveManager.save_game.call_deferred()
	node.queue_free()

