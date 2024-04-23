extends Area2D
class_name MouseDragDropArea

signal dropped(drag_data: Dictionary)

@export var owner_node: Node

@export var texture_node: CanvasItem

@export var can_drop_condition_method: String

func drop(controller: MouseDragArea) -> void: 
	
	if texture_node: 
		if has_texture_property(texture_node): 
			texture_node.texture = controller.node.texture
		
		var children: Array[Node] = texture_node.get_children()

		NodeTools.explore_children(
			controller.node, 
			func(child: Node, i: int): 
				if has_texture_property(child) && has_texture_property(children[i]): 
					children[i].texture = child.texture 
		)
	
	dropped.emit(MouseDrag.drag_data)
	
	
func has_texture_property(node: Node) -> bool: 
	return node.has("texture")


func can_drop() -> bool: 
	if can_drop_condition_method.is_empty(): 
		return true
		
	return Callable(owner_node, can_drop_condition_method).call(MouseDrag.drag_data)
	
	
