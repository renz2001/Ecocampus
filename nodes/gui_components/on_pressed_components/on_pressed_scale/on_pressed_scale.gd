extends OnPressedComponent

@export var tween: TweenArguments: 
	set(value): 
		tween = value
		if !is_node_ready(): 
			await ready
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
		scale_lerp.percentage = percentage
	
@export var scale_lerp: Vector2PropertyLerpComponent
