@tool
extends NodeComponent
class_name HoverNodeComponent

# FIXME: Does not work yet. 

@export var node: CanvasItem
@export var autoplay: bool
@export var loops: int = -1
@export var is_playing: bool

@export var up_offset: float
@export var down_offset: float

@export var up_lerp: Vector2PropertyLerpComponent
@export var down_lerp: Vector2PropertyLerpComponent
#@export var play_button: bool: 
	#set(value): 
		#play()


func _ready() -> void: 
	if autoplay: 
		play()
		pass
		
		
func play() -> void: 
	is_playing = true
	if loops > 0: 
		for i in loops: 
			await _hover_loop()
		is_playing = false
	elif loops < 0: 
		while is_playing: 
			await _hover_loop()
	
	
func _hover_loop() -> void: 
	up_lerp.end_point = node.global_position + Vector2(0, up_offset)
	up_lerp.start_point = node.global_position
	down_lerp.end_point = node.global_position + Vector2(0, down_offset)
	down_lerp.start_point = node.global_position
	up_lerp.play()
	await up_lerp.finished
	down_lerp.play()
	await down_lerp.finished
	
	
	
