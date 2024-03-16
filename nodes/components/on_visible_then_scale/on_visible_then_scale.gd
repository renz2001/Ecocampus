@tool
extends OnVisibleDo

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


func _on_visible() -> void: 
	if !node.is_node_ready(): 
		await node.ready
	if node.visible: 
		play()
		
	
func play() -> void: 
	percentage = 0
	scale_lerp.play()
	
	
func end() -> void: 
	percentage = 1
	scale_lerp.play(0)
	
	
func set_node(value: CanvasItem) -> void: 
	node = value
	if !is_node_ready(): 
		await ready
	scale_lerp.node = node
	scale_lerp.start_point = start_scale
	scale_lerp.end_point = end_scale
	
