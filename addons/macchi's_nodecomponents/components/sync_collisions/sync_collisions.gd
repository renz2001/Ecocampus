@tool
extends NodeComponent


@export var from: CollisionShape2D
@export var to: CollisionShape2D

@export var process_enabled: bool = true


func _physics_process(delta: float) -> void: 
	if !process_enabled: 
		return
	to.shape = from.shape
	
	
