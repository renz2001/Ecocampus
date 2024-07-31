extends OnPressedComponent
class_name OnPressedToggleMute

@export var audio_bus: int = 0
@export var audio_bus_volume_slider: AudioBusVolumeSlider


func _on_pressed() -> void: 
	audio_bus_volume_slider.audio_bus = audio_bus
	audio_bus_volume_slider.toggle_mute()
