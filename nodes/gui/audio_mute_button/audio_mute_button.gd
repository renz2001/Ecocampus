extends TextureButtonPlus
class_name AudioMuteButton

@export var audio_bus: int = 1
@export var silent_icon: Texture2D
@export var sound_icon: Texture2D
@export var on_pressed_toggle_mute: OnPressedToggleMute

func _ready() -> void: 
	update()


func update() -> void: 
	on_pressed_toggle_mute.audio_bus = audio_bus
	if AudioServer.is_bus_mute(audio_bus): 
		texture_normal = silent_icon
	else: 
		texture_normal = sound_icon


func _on_on_pressed_toggle_mute_pressed() -> void:
	update()
