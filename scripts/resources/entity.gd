extends Resource
class_name Entity

signal name_changed
signal speaker_sprite_changed

@export var name: String: 
	set(value): 
		name = value
		name_changed.emit()


@export var speaker_sprite: Texture2D: 
	set(value): 
		speaker_sprite = value
		speaker_sprite_changed.emit()
		
		
