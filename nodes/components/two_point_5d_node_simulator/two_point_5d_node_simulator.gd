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
@export var disabled: bool

var node_base_scale: Vector2
var base_movement_speed: float


var weight: float: 
	get: 
		return node.global_position.y


func _process(delta: float) -> void: 
	if disabled || !node || !node.is_node_ready(): 
		return
	if !is_instance_valid(space_simulator) && !Engine.is_editor_hint(): 
		space_simulator = get_tree().get_first_node_in_group("TwoPoint5DSpaceSimulator")
	if !space_simulator:
		return
		
	#print(space_simulator.get_weight(node.global_position))
	#print(Vector2(node_base_scale.y * space_simulator.get_node_scale(node), node_base_scale.y * space_simulator.get_node_scale(node)))
	#space_simulator.get_space_scale(node)
	var new_scale = Vector2(node_base_scale.y * space_simulator.get_space_scale(node), node_base_scale.y * space_simulator.get_space_scale(node))
	#print(new_scale)
	node.scale = new_scale
	#node.scale = node_base_scale * Vector2(space_simulator.get_space_scale(node.global_position.y).y, space_simulator.get_space_scale(node.global_position.y).y)
	
	#if movement && movement.direction.y != 0: 
		#movement.speed = base_movement_speed * space_simulator.get_space_scale(node)
	#elif movement: 
		#movement.speed = base_movement_speed

