@tool
extends PanelContainer
class_name VolumeSlider

@export var label: Label
@export var slider: HSlider
@export var audio_bus_volume_slider: AudioBusVolumeSlider
@export var percentage_label: FormattedLabel

@export var audio_bus: int = 0: 
	set(value): 
		audio_bus = value
		if !is_node_ready(): 
			await ready
		update()


func _ready(): 
	update()
	
	
func update() -> void: 
	label.text = AudioServer.get_bus_name(audio_bus)
	audio_bus_volume_slider.audio_bus = audio_bus


func _on_h_slider_drag_started() -> void:
	set_process(true)


func _on_h_slider_drag_ended(_value_changed: bool) -> void:
	set_process(false)


func _process(_delta: float) -> void: 
	percentage_label.text = str(slider.value * 100)
	audio_bus_volume_slider.value = slider.value
	
	
	
