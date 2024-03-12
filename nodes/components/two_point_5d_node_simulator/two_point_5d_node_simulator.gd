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
		if !movement.is_node_ready(): 
			await movement.ready
		base_movement_speed = movement.speed + 1
		
@export var path_find: PathFindMovementComponent

@export var space_simulator: TwoPoint5DSpaceSimulator
@export var disabled: bool

var node_base_scale: Vector2
var base_movement_speed: float


var weight: float: 
	get: 
		return node.global_position.y


func _process(_delta: float) -> void: 
	if disabled || !node || !node.is_node_ready(): 
		return
	if !is_instance_valid(space_simulator): 
		space_simulator = get_tree().get_first_node_in_group("TwoPoint5DSpaceSimulator")
	if !space_simulator:
		return
		
	var space_scale: float = space_simulator.get_space_scale(node.global_position, base_movement_speed)
	var new_scale = Vector2(node_base_scale.y * space_scale, node_base_scale.y * space_scale)
	
	node.scale = new_scale
	
	#printerr(node.global_position.x)
	#space_simulator.get_offset_from_max_distance(node.global_position)
	#if path_find: 
		#if !Engine.is_editor_hint() && movement.is_moving() && is_instance_valid(path_find.target): 
			#path_find.target.global_position.x *= space_simulator.get_offset_from_max_distance(node.global_position)
	#print(space_simulator.get_offset_from_max_distance(node.global_position))
	
	if movement: 
		#print((space_scale / 3))
		movement.y_speed_multiplier = base_movement_speed * (space_scale / base_movement_speed)
	
	
