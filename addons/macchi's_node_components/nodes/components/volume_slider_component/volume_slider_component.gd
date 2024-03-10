@tool
extends NodeComponent
class_name VolumeSliderComponent


@export_range(0, 1) var value: float: 
	set(value): 
		value = value
		if audio_player: 
			audio_player.volume_db = linear_to_db(value)
		
@export var audio_player: Node
@export var use_parent: bool: 
	set(value): 
		use_parent = value
		if use_parent: 
			audio_player = get_parent()
		else: 
			audio_player = null


func _enter_tree() -> void: 
	use_parent = use_parent

