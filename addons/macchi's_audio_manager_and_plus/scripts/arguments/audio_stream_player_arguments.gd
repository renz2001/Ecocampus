extends Resource
class_name AudioStreamPlayerArguments


@export var sound: AudioStream
@export var play_from_position: int = 0

@export var pitch_scale: float = 1
@export var bus: GlobalVariables.AudioBusses


func set_sound(s: AudioStream) -> AudioStreamPlayerArguments: 
	sound = s
	return self
	
	
func set_play_from_position(pos: int) -> AudioStreamPlayerArguments: 
	play_from_position = pos
	return self
	
	
func set_pitch_scale(pitch: float) -> AudioStreamPlayerArguments: 
	pitch_scale = pitch
	return self


func set_bus(b: GlobalVariables.AudioBusses) -> AudioStreamPlayerArguments: 
	bus = b
	return self
	
	
