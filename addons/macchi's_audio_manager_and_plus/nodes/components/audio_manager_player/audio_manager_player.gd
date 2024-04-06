extends NodeComponent
class_name AudioManagerPlayer

enum Type {
	SOUND_EFFECT, 
	MUSIC, 
	TEMPORARY_MUSIC
}

@export var type: Type
@export var audio: AudioStreamPlayerArguments
@export var autoplay: bool
@export var disabled: bool
@export var print_color: PrintColor


func _ready() -> void: 
	if autoplay: 
		play()


func play() -> void: 
	if !is_instance_valid(audio): 
		return
	if disabled: 
		return
	match type: 
		Type.SOUND_EFFECT: 
			AudioManager.play_sound_effect(audio)
		Type.MUSIC: 
			AudioManager.play_music(audio)
			print_color.out_debug_wvalue("Started Music", audio.sound.resource_path)
		Type.TEMPORARY_MUSIC: 
			AudioManager.play_temporary_music(audio)


func _on_ready_unique_resource_resource_ready() -> void:
	print_color.owner = self
