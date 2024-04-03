@tool
extends NodeComponent
class_name AudioBusVolumeSlider

signal muted_changed

@export_range(0, 1) var value: float = 1: 
	set(val): 
		value = val
		AudioServer.set_bus_volume_db(audio_bus, linear_to_db(value))
		
		
@export var mute: bool: 
	set(val): 
		mute = val
		AudioServer.set_bus_volume_db(audio_bus, mute)
		muted_changed.emit()
	get: 
		return AudioServer.is_bus_mute(audio_bus)

@export var audio_bus: int


func toggle_mute() -> void: 
	mute = !mute
	
	
