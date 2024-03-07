@tool
extends FloatLerpComponent
class_name FloatPropertyLerpComponent

@export var reset_node_when_finished: bool
@export var node: Node
@export var properties: PackedStringArray


func _on_interpolated(value: Variant) -> void: 
	print(node.get("modulate:a"))
	for property: String in properties: 
		printerr(node.get(property))
		node.set(property, value)


func _is_finished() -> void: 
	#if reset_points_when_finished: 
		#start_point = 0
		#end_point = 0
	if reset_node_when_finished: 
		node = null
	if reset_current_when_finished: 
		current = 0
	super._is_finished()


func set_reset_all_when_finished(value: bool) -> void: 
	super.set_reset_all_when_finished(value)
	reset_node_when_finished = value
	
	
