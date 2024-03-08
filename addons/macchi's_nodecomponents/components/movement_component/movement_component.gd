extends NodeComponent
class_name MovementComponent

signal moved
signal stopped
signal direction_changed(previous_direction: Vector2, new_direction: Vector2)

@export var body: Node

@export var speed: float
@export var y_speed_multiplier: float
@export var curve_base_on_center_offset: bool

# This cannot be set to Vector2(0, 0) becuase this is used so that interact_cast works with it
var previous_direction: Vector2 = Vector2(0, 1)
var direction: Vector2 = Vector2(0, 1): 
	set(value): 
		if _has_moved_yet == false: 
			moved.emit()
			_has_moved_yet = true
		if direction == Vector2.ZERO: 
			_has_moved_yet = false
		var new_direction: Vector2 = value.normalized()
		var _previous_direction: Vector2 = direction
		direction = new_direction
		if _previous_direction != new_direction: 
			direction_changed.emit(_previous_direction, new_direction)
			
# This variable is for the moved signal, hence why it is private. 
# It is also used in the movement_direction setter. 
var _has_moved_yet: bool = false
#var current_speed: float: 
	#get: 
		#if direction == Vector2.ZERO: 
			#return 0
		#return current_speed

## Set direction first before using. 
## Put this in _physics_process. 
func move(_direction: Vector2) -> void: 
	direction = _direction
	#current_speed = speed
	# TODO: Be controlled by the animation player instead. 
	#if move_audio_player: 
		#move_audio_player.play()
	set_velocity(direction * GlobalVariables.get_tile_scaled_speed(speed))


func stop() -> void: 
	set_velocity(Vector2.ZERO)
	stopped.emit()
	
	
func is_moving() -> bool: 
	if direction != Vector2.ZERO: 
		return true
	return false


func set_velocity(velocity: Vector2) -> void: 
	var node: Node = body
	#if curve_base_on_center_offset: 
		#node.velocity.x = velocity.x + get_node_offset_from_center()
		#node.velocity.y = velocity.y
		#printerr(get_node_offset_from_center())
	#else:
	#node.velocity = velocity
	node.velocity.x = velocity.x
	node.velocity.y = velocity.y * y_speed_multiplier
	node.move_and_slide() 


#func get_center() -> int: 
	#return GlobalVariables.viewport_size.x / 2
	#
	#
#func get_offsetted_center(offset: float = 0) -> int: 
	#return get_center() + offset
	#
	#
#func get_node_offset_from_center() -> int: 
	#return get_offsetted_center(50) - body.global_position.x
