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


func _ready() -> void: 
	if autoplay: 
		play()


func play() -> void: 
	match type: 
		Type.SOUND_EFFECT: 
			AudioManager.play_temporary_sound(audio)
		Type.MUSIC: 
			AudioManager.play_music(audio)
		Type.TEMPORARY_MUSIC: 
			AudioManager.play_temporary_music(audio)

