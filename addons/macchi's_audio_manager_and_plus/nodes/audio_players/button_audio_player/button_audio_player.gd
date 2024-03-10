## Connect to a button, it will connect it's signals and automatically add sounds for the player. 
extends NodeComponent
class_name ButtonAudioPlayer

@export var button: BaseButton: 
	set(value): 
		button = value
		button.pressed.connect(_on_pressed)
		button.focus_entered.connect(_on_focus_entered)
		
@export var player: AudioManagerPlayer
@export var audio: ButtonAudio


func _on_pressed() -> void: 
	player.audio = AudioStreamPlayerArguments.new().set_sound(audio.pressed)
	player.play()
	#printerr("PRESSED") 
	
	
func _on_focus_entered() -> void: 
	#if get_viewport().gui_get_focus_owner() == button: 
		#return
	player.audio = AudioStreamPlayerArguments.new().set_sound(audio.focus_entered)
	player.play()
	#printerr("FOCUS") 
