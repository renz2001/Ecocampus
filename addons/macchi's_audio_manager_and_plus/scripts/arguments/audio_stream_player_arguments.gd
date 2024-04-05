extends Resource
class_name AudioStreamPlayerArguments


@export var sound: AudioStream
@export var play_from_position: int = 0

@export var pitch_scale: float = 1

@export_range(0, 1) var volume_slider: float = 1

@export var volume_db: float = 0

@export var bus: String


func set_sound(s: AudioStream) -> AudioStreamPlayerArguments: 
	sound = s
	return self
	
	
func set_play_from_position(pos: int) -> AudioStreamPlayerArguments: 
	play_from_position = pos
	return self
	
	
func set_pitch_scale(pitch: float) -> AudioStreamPlayerArguments: 
	pitch_scale = pitch
	return self


func set_bus(b: String) -> AudioStreamPlayerArguments: 
	bus = b
	return self
	
	
func set_volume_slider(value: float) -> AudioStreamPlayerArguments: 
	volume_slider = value
	return self
	
	
func set_volume_db(value: float) -> AudioStreamPlayerArguments: 
	volume_db = value
	return self
	
	
func get_volume() -> float: 
	if volume_db > 0: 
		return volume_db
	return linear_to_db(volume_slider)
