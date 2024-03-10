@tool
extends NodeComponent
class_name PathFindMovementComponent

signal move_finished

@export var debug: bool = false
@export var movement: MovementComponent
@export var navigation_agent: NavigationAgent2D

@export var target: Node

var line: Line2D
var _is_setup: bool = false

func _ready() -> void: 
	if Engine.is_editor_hint(): 
		return
	set_physics_process(false)
	call_deferred('_setup')


func _setup() -> void: 
	await get_tree().physics_frame
	set_physics_process(true)


func _physics_process(_delta: float) -> void: 
	if Engine.is_editor_hint(): 
		return
	_is_setup = true


func stop() -> void: 
	target = null
	move_finished.emit()
	
	
## Set the target first. 
## Put this in _physics_process. 
func move() -> bool: 
	if target && move_to_position(target.global_position, movement.speed): 
		return true
	#target = null
	return false
	
	
func move_to_position(position: Vector2, speed: float) -> bool: 
	if Engine.is_editor_hint(): 
		return false
	if !_is_setup: 
		return true
	navigation_agent.max_speed = GlobalVariables.get_tile_scaled_speed(speed) # Test
	var body: Node = movement.body
	navigation_agent.target_position = position

	if navigation_agent.is_navigation_finished(): 
		move_finished.emit()
		return false
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	
	#if debug: 
		#if !navigation_agent.get_current_navigation_path().is_empty(): 
			#if !line: 
				#var create_line: CreateLine = CreateLine.new(navigation_agent.get_current_navigation_path()) 
				#line = DebugTools.create_line(self, create_line, 60)
			#elif line: 
				#line.points = navigation_agent.get_current_navigation_path()
			
	var movement_direction: Vector2 = body.global_position.direction_to(next_path_position)
	movement.direction = movement_direction
	var new_velocity: Vector2 = movement_direction * GlobalVariables.get_tile_scaled_speed(speed)
	navigation_agent.set_velocity(new_velocity)
	return true
	
	
## Connect nav agent signal here
func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void: 
	if Engine.is_editor_hint(): 
		return
	movement.set_velocity(safe_velocity)
	
	
func _get_configuration_warnings() -> PackedStringArray: 
	var warnings = []
	if !is_instance_valid(navigation_agent): 
		warnings.append("Must add navigation agent.")
	return warnings

