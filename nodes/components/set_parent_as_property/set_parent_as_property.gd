@tool
extends NodeComponent
class_name SetParentAsProperty


@export var node: Node
@export var property: String = "node"


func _ready() -> void: 
	if !Engine.is_editor_hint(): 
		return 
	if node != null: 
		node.set(property, node.get_parent())
	
	
