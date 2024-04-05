## Connect to a button, it will connect it's signals and automatically add sounds for the player. 
extends NodeComponent
class_name ButtonAudioPlayer

@export var button: BaseButton: 
	set(value): 
		button = value
		if button: 
			button.pressed.connect(_on_pressed)
			button.focus_entered.connect(_on_focus_entered)
		
@export var player: AudioManagerPlayer
@export var audio: ButtonAudio
@export var disabled: bool: 
	set(value): 
		disabled = value
		if !is_node_ready(): 
			await ready
		player.disabled = disabled

@export_range(0, 1) var volume_slider: float = 1


func _on_pressed() -> void: 
	if audio.pressed: 
		player.audio = AudioStreamPlayerArguments.new().set_sound(audio.pressed).set_volume_slider(volume_slider)
		player.play()
	#printerr("PRESSED") 
	
	
func _on_focus_entered() -> void: 
	#if get_viewport().gui_get_focus_owner() == button: 
		#return
	if audio.focus_entered: 
		player.audio = AudioStreamPlayerArguments.new().set_sound(audio.focus_entered).set_volume_slider(volume_slider)
		player.play()
	#printerr("FOCUS") 
