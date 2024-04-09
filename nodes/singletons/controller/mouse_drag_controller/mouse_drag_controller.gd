extends Area2D

signal dragging_started
signal dragging_cancelled
signal dragging_ended
signal dropped

@export var collision: CollisionShape2D
@export var collision_size_offset: Vector2

var is_dragging: bool

var current_controller: MouseDragArea
var node_being_dragged: CanvasItem
var drag_data: Dictionary


func _process(_delta: float) -> void: 
	if is_instance_valid(node_being_dragged): 
		if node_being_dragged is TextureRect: 
			node_being_dragged.global_position = get_global_mouse_position() - node_being_dragged.pivot_offset
		else: 
			node_being_dragged.global_position = get_global_mouse_position()
		collision.global_position = get_global_mouse_position()


func drag(drag_area: MouseDragArea) -> void: 
	is_dragging = true
	
	var dupe: CanvasItem = drag_area.drag_node.duplicate()
	
	add_child(dupe)
	
	if dupe is Control: 
		dupe.size = drag_area.drag_node.size
		collision.shape.size = dupe.size + collision_size_offset
		dupe.mouse_filter = Control.MOUSE_FILTER_IGNORE
		if dupe is TextureRect: 
			dupe.pivot_offset = dupe.size / 2
			
	drag_data = drag_area.get_drag_data()
	dupe.show()
	drag_area.drag_node.hide()
	
	node_being_dragged = dupe
	current_controller = drag_area
	
	dragging_started.emit() 
	
	
func _input(event: InputEvent) -> void: 
	if Mouse.is_released(event) && is_dragging: 
		if has_overlapping_areas(): 
			var areas: Array[Area2D] = get_overlapping_areas() 
			drop_at(areas[0])
		else: 
			cancel()
	
	
func _clear() -> void: 
	if current_controller: 
		current_controller.drag_node.show()
		current_controller = null
		
	if node_being_dragged: 
		node_being_dragged.queue_free()
		node_being_dragged = null
	
	collision.global_position = Vector2.ZERO
	drag_data.clear()
	
	dragging_ended.emit()
	is_dragging = false
	
	
func drop_at(drag_area: MouseDragDropArea) -> void: 
	if drag_area.can_drop(): 
		drag_area.drop(current_controller)
		dropped.emit()
		_clear()
	else: 
		cancel()
		
	
func cancel() -> void: 
	_clear()
	dragging_cancelled.emit()
	
