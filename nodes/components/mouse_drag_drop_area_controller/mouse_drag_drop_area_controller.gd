extends Area2D
class_name MouseDragDropAreaController

signal dropped(drag_data: Dictionary)

@export var owner_node: Node

@export var texture_node: CanvasItem

func drop(controller: MouseDragAreaController) -> void: 
	
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
	
	dropped.emit(controller.get_drag_data())
	
	
func has_texture_property(node: Node) -> bool: 
	return node.has("texture")

