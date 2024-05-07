## Attach this to make a node follow anything
@tool
extends NodeComponent
class_name FollowNodeComponent

signal following_new_node(node: Node2D)

## Owner
@export var node: Node2D
## Node to follow
@export var following_node: Node2D: 
	set(value): 
		following_node = value
		following_new_node.emit(following_node)
@export var follow_node: bool = true

@export var smoothing: TweenArguments
@export var weight: float = 0
@export var offset: Vector2

@export var base_values: BaseValuesKeeper


func follow(to_follow: Node2D) -> void: 
	following_node = to_follow


func stop() -> void: 
	following_node = null


func _physics_process(_delta: float) -> void: 
	if !is_instance_valid(following_node): 
		return
	if !follow_node: 
		return
	var new: Vector2 = Tween.interpolate_value(node.global_position, following_node.global_position - node.global_position, weight * smoothing.duration, smoothing.duration, smoothing.transition_type, smoothing.ease_type) - offset
	node.global_position = new


func back_to_position() -> void: 
	node.global_position = base_values.values.global_position


func _get_configuration_warnings() -> PackedStringArray: 
	var warnings = []
	if !is_instance_valid(node): 
		warnings.append("Missing node")
	if !is_instance_valid(following_node): 
		warnings.append("Missing follow node")
	if !is_instance_valid(base_values.node): 
		warnings.append("Give BaseValuesKeeper the owner node as well. ")
	return warnings
