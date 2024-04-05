extends TextureButtonPlus
class_name AudioMuteButton


@export var silent_icon: Texture2D
@export var sound_icon: Texture2D


func _ready() -> void: 
	update()


func update() -> void: 
	if AudioServer.is_bus_mute(0): 
		texture_normal = silent_icon
	else: 
		texture_normal = sound_icon


func _on_on_pressed_toggle_mute_pressed() -> void:
	update()
