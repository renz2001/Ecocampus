extends NodeComponent
class_name PointAndClickController


@export var node: Node2D
@export var disabled: bool
@export var path_find_move_component: PathFindMovementComponent

var target: Marker2D


func _unhandled_input(event: InputEvent) -> void: 
	if disabled: 
		return
		
	if event.is_action_pressed("tap"): 
		var mouse_pos: Vector2 = get_viewport().get_mouse_position()
		target = Marker2D.new()
		get_tree().current_scene.add_child(target)
		path_find_move_component.target = target


func _physics_process(delta: float) -> void: 
	if !path_find_move_component.move(): 
		target.queue_free()
		
		
