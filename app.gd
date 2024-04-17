extends Node
class_name App

@export var audio_bus_volume_slider: AudioBusVolumeSlider
@export var main_scene: ChangeSceneComponent

func _ready() -> void: 
	
	if OS.is_debug_build(): 
		audio_bus_volume_slider.value = 0.1
		
	main_scene.change()
	
	
