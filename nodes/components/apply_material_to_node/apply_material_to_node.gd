@tool
extends NodeComponent
class_name ApplyMaterialToNode

@export var apply: bool: 
	set(value): 
		apply = value
		if !node.is_node_ready(): 
			await node.ready
		if apply: 
			_apply()
		else: 
			_conceal()
		
@export var node: CanvasItem
@export var material: Material

@export var duration: float: 
	set(value): 
		duration = value
		if !is_node_ready(): 
			await ready
		if duration > 0: 
			duration_timer.wait_time = duration
		
@export var duration_timer: Timer


func toggle() -> void: 
	apply = !apply


func show() -> void: 
	apply = true


func hide() -> void: 
	apply = false
	
	
func _apply() -> void: 
	node.material = material
	if duration > 0: 
		duration_timer.timeout.connect(
			func(): 
				apply = false
		, CONNECT_ONE_SHOT
		)
		duration_timer.start()
	
	
func _conceal() -> void: 
	node.material = null
