@tool
extends OnVisibleDo

@export var tween: TweenArguments: 
	set(value): 
		tween = value
		if !is_node_ready(): 
			await ready
		position_lerp.interpolation = tween
		scale_lerp.interpolation = tween
		
@export var start_scale: Vector2 = Vector2.ZERO: 
	set(value): 
		start_scale = value
		if !is_node_ready(): 
			await ready
		scale_lerp.start_point = start_scale
		
@export var end_scale: Vector2 = Vector2.ONE: 
	set(value): 
		end_scale = value
		if !is_node_ready(): 
			await ready
		scale_lerp.end_point = end_scale
		
@export_range(0, 1) var percentage: float: 
	set(value): 
		percentage = value
		if !is_node_ready(): 
			await ready
		position_lerp.percentage = percentage
		scale_lerp.percentage = percentage
	
@export var starting_point: Marker2D
@export var ending_point: Marker2D
@export var position_lerp: Vector2PropertyLerpComponent
@export var scale_lerp: Vector2PropertyLerpComponent



func _on_visible(value: bool) -> void: 
	#if value: 
		#play()
	pass
	
func play() -> void: 
	percentage = 0
	position_lerp.play()
	scale_lerp.play()
	
	
func end() -> void: 
	percentage = 1
	position_lerp.play(0)
	scale_lerp.play(0)
	
	
func set_node(value: CanvasItem) -> void: 
	node = value
	if !is_node_ready(): 
		await ready
	position_lerp.node = node
	position_lerp.start_point = starting_point.global_position
	position_lerp.end_point = ending_point.global_position
	scale_lerp.node = node
	scale_lerp.start_point = start_scale
	scale_lerp.end_point = end_scale
	
