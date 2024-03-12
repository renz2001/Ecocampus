extends NodeComponent
class_name MoveToTapPathFindMovement

signal tapped(mouse_position: Vector2)

@export var node: Node2D
@export var disabled: bool
@export var mouse_position: MousePositionComponent
@export var path_find_move_component: PathFindMovementComponent

var target: Marker2D


func move() -> void: 
	#if disabled: 
		#return
		#
	#if event.is_action_pressed("tap"): 
	var mouse_pos: Vector2 = node.get_global_mouse_position()
	if is_instance_valid(target): 
		target.queue_free()
	target = Marker2D.new()
	target.global_position = mouse_pos

	#print(target.global_position)
	get_tree().current_scene.add_child(target)
	path_find_move_component.target = target
	tapped.emit(mouse_pos)


func _physics_process(_delta: float) -> void: 
	if is_instance_valid(target): 
		var is_moving: bool = path_find_move_component.move()
		#print(is_moving)
		if !is_moving: 
			target.queue_free()
		
		
