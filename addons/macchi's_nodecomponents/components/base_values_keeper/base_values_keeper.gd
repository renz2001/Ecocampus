@tool
extends NodeComponent
class_name BaseValuesKeeper

## Node to keep values
@export var node: Node
@export var node_is_parent: bool = true
@export var values_to_keep: PackedStringArray

var values: Dictionary = {}


func _ready() -> void: 
	if Engine.is_editor_hint(): 
		return
	if !is_instance_valid(node): 
		return
	if node_is_parent: 
		node.ready.connect(
			func(): 
				update()
		, CONNECT_ONE_SHOT
		)
	else: 
		update()


func update() -> void: 
	if !is_instance_valid(node): 
		push_error("(%s) BaseValuesKeeper: node is null. " % get_parent())
		return
	for val in values_to_keep: 
		values[val] = node.get(val)


func _get_configuration_warnings() -> PackedStringArray: 
	var warnings: PackedStringArray = []
	if node != get_parent() && node_is_parent: 
		warnings.append("The node has to be the same as the parent. ")
	return warnings
