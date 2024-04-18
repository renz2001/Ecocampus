extends NodeComponent
class_name HoverNodeComponent

@export var node: CanvasItem
@export var autoplay: bool
@export var loops: int = -1

@export var up_lerp: Vector2PropertyLerpComponent
@export var down_lerp: Vector2PropertyLerpComponent


func _ready() -> void: 
	if autoplay: 
		play()
		
		
func play() -> void: 
	pass
	
	
func _hover_loop() -> void: 
	pass
	
	
	
