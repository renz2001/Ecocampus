@tool
extends ColorLerpComponent
class_name ColorPropertyLerpComponent

@export var reset_node_when_finished: bool
@export var node: Node
@export var properties: PackedStringArray

func _on_interpolated(value: Color) -> void:
	for property: String in properties: 
		node.set(property, value)


func _is_finished() -> void: 
	if reset_node_when_finished: 
		node = null
	super._is_finished()


func set_reset_all_when_finished(value: bool) -> void: 
	super.set_reset_all_when_finished(value)
	reset_node_when_finished = value
	
