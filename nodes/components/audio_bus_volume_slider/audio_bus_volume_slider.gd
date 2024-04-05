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
		AudioServer.set_bus_mute(audio_bus, mute)
		print_color.out_debug_wvalue("AudioBus %s: mute is set to" % audio_bus, AudioServer.is_bus_mute(audio_bus))
		muted_changed.emit()


@export var audio_bus: int
@export var print_color: PrintColor: 
	set(value): 
		print_color = value
		print_color.owner = self


func toggle_mute() -> void: 
	mute = !mute
	
	
