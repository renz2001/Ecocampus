extends NodeHandler
class_name MultipleNodeHandler




func _on_entered_node(_entered_node: Node) -> void: 
	_entered_node.disabled = false
	_entered_node.init()


func _on_exited_node(_exited_node: Node) -> void:
	_exited_node.disabled = true
	
	
