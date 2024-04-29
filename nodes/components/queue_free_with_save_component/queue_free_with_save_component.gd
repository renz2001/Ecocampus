extends NodeComponent
class_name QueueFreeWithSaveComponent

@export var node: Node

func use() -> void: 
	#node.master_save_component.is_queued_free = true
	#if !SaveManager.current_saved_data.data.has("QueuedFree"): 
		#if SaveManager.current_saved_data.data["QueuedFree"].is_empty(): 
			#SaveManager.current_saved_data.data["QueuedFree"] = []
	var queued_frees: Array = SaveManager.current_saved_data.data["QueuedFree"]
	queued_frees.append(node.get_path())
	#printerr(queued_frees)
	SaveManager.save_game.call_deferred()
	node.queue_free()

