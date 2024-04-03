extends OnPressedComponent

@export var audio_bus_volume_slider: AudioBusVolumeSlider


func _on_pressed() -> void: 
	audio_bus_volume_slider.toggle_mute()

