## Includes a built in interpolation in between snaps. Automatically determines the size of each snap with the use of the total size of the container. Only works if each column/row in the container is the same size. 
@tool
extends ScrollContainer
class_name ScrollSnapContainer

enum ScrollDirection {
	HORIZONTAL, 
	VERTICAL
}

#@export var snaps: int: 
	#set(value): 
		#snaps = value

@export var scroll_direction: ScrollDirection

@export var current_snap_index: int: 
	set(value): 
		current_snap_index = clamp(value, 0, get_scroll_children_size())
		if !is_node_ready(): 
			await ready
			
		var snap_size: Vector2 = get_scroll_size() / get_scroll_children_size()
		
		match scroll_direction: 
			ScrollDirection.HORIZONTAL: 
				scroll_horizontal_lerp.start_point = scroll_horizontal
				scroll_horizontal_lerp.end_point = snap_size.x * current_snap_index
				scroll_horizontal_lerp.play()
				
			ScrollDirection.VERTICAL: 
				scroll_vertical_lerp.start_point = scroll_vertical
				scroll_vertical_lerp.end_point = snap_size.y * current_snap_index
				scroll_vertical_lerp.play()
		
@export var interpolation: TweenArguments: 
	set(value): 
		interpolation = value
		if !is_node_ready(): 
			await ready
		scroll_horizontal_lerp.interpolation = interpolation
		scroll_vertical_lerp.interpolation = interpolation


@export var scroll_horizontal_lerp: FloatPropertyLerpComponent
@export var scroll_vertical_lerp: FloatPropertyLerpComponent


func next() -> void: 
	current_snap_index += 1
	
	
func back() -> void: 
	current_snap_index -= 1


func get_scroll_size() -> Vector2: 
	var container: Container = get_container()
	if container != null: 
		return get_container().size
	return Vector2.ZERO


func get_scroll_children_size() -> int: 
	return get_container().get_child_count()
	
	
func get_container() -> Container: 
	for child: Node in get_children(): 
		if child is Container: 
			return child
	return null
