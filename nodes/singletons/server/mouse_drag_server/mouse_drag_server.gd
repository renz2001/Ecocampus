extends Area2D

signal dragging_started
signal dragging_cancelled
signal dragging_ended
signal dropped

@export var collision: CollisionShape2D
@export var collision_size_offset: Vector2

var is_dragging: bool

var current_controller: MouseDragAreaController
var node_being_dragged: CanvasItem


func _process(_delta: float) -> void: 
	if is_instance_valid(node_being_dragged): 
		if node_being_dragged is TextureRect: 
			node_being_dragged.global_position = get_global_mouse_position() - node_being_dragged.pivot_offset
		else: 
			node_being_dragged.global_position = get_global_mouse_position()
		collision.global_position = get_global_mouse_position()

func drag(controller: MouseDragAreaController) -> void: 
	is_dragging = true
	
	var dupe: CanvasItem = controller.drag_node.duplicate()
	
	add_child(dupe)
	
	if dupe is Control: 
		dupe.size = controller.drag_node.size
		collision.shape.size = dupe.size + collision_size_offset
		dupe.mouse_filter = Control.MOUSE_FILTER_IGNORE
		if dupe is TextureRect: 
			dupe.pivot_offset = dupe.size / 2
		
	controller.drag_node.hide()
	
	node_being_dragged = dupe
	current_controller = controller
	
	dragging_started.emit() 
	
	
func _input(event: InputEvent) -> void: 
		if Mouse.is_released(event): 
			if has_overlapping_areas(): 
				var areas: Array[Area2D] = get_overlapping_areas() 
				drop_at(areas[0])
			else: 
				cancel()
	
	
func _clear() -> void: 
	if node_being_dragged: 
		node_being_dragged.queue_free()
		node_being_dragged = null
		dragging_ended.emit()
		is_dragging = false
	
	
func drop_at(controller: MouseDragDropAreaController) -> void: 
	controller.drop(current_controller)
	_clear()
	dropped.emit()
	
	
func cancel() -> void: 
	_clear()
	dragging_cancelled.emit()
	
