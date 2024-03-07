@tool
extends NodeComponent
class_name TwoPoint5DNodeSimulator

@export var node: Node2D: 
	set(value): 
		node = value
		node_base_scale = node.scale
		
@export var movement: MovementComponent: 
	set(value): 
		movement = value
		base_movement_speed = movement.speed
		
@export var space_simulator: TwoPoint5DSpaceSimulator

var node_base_scale: Vector2
var base_movement_speed: float


var weight: float: 
	get: 
		return node.global_position.y


func _process(delta: float) -> void: 
	if !node.is_node_ready(): 
		return
	if !is_instance_valid(space_simulator) && !Engine.is_editor_hint(): 
		space_simulator = get_tree().get_first_node_in_group("TwoPoint5DSpaceSimulator")
		
	#print(space_simulator.get_weight(node.global_position))
	#print(Vector2(node_base_scale.y * space_simulator.get_node_scale(node), node_base_scale.y * space_simulator.get_node_scale(node)))
	node.scale = Vector2(node_base_scale.y * space_simulator.get_node_scale(node), node_base_scale.y * space_simulator.get_node_scale(node))
	
	#node.scale = node_base_scale * Vector2(space_simulator.get_space_scale(node.global_position.y).y, space_simulator.get_space_scale(node.global_position.y).y)
	
	#if movement: 
		#movement.speed = base_movement_speed * space_simulator.get_space_scale(weight)

