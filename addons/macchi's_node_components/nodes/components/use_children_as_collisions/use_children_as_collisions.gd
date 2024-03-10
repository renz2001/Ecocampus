@tool
extends NodeComponent
class_name UseChildrenAsCollisions


@export var node: Node
@export var collision_object: CollisionObject2D
@export var duplicate_collisions: bool
@export var disabled: bool


func _ready() -> void: 
	if disabled: 
		return
	if Engine.is_editor_hint(): 
		return
	NodeTools.move_collisions(node, collision_object)


func get_collisions() -> Array[Node]: 
	return NodeTools.get_collisions(node)


func get_configuration_warnings() -> PackedStringArray: 
	var warnings = []
	var collisions: int = 0
	for child in node.get_children(): 
		if child is CollisionShape2D or child is CollisionPolygon2D: 
			collisions += 1
	if collisions == 0: 
		warnings.append("This node must have a CollisionShape2D")
	return warnings

