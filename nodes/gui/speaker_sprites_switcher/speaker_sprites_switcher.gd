@tool
extends TabContainer
class_name SpeakerSpritesSwitcher


enum Speaker {
	MAIN, 
	SECONDARY
}

@export var speaker: Speaker: 
	set(value): 
		speaker = value
		if speaker == Speaker.MAIN: 
			current_tab = 0
			#main_speaker_texture_rect.texture = _get_speaker_sprite(main_speaker)
			current_speaker_rect = main_speaker_texture_rect
		else: 
			current_tab = 1
			current_speaker_rect = secondary_speaker_texture_rect
			#secondary_speaker_texture_rect.texture = secondary_speaker.speaker_sprite
			
@export var main_speakers: Array[Entity]

@export var current_speaker_rect: TextureRect

@export var main_speaker_texture_rect: TextureRect
@export var secondary_speaker_texture_rect: TextureRect

@export var entities: EntityCollection


func get_speaker_idle_sprite(entity_name: String) -> Texture2D: 
	var entity: Entity = NodeTools.get_item_from_array(entities.entities, 
		func(item: Entity, _i: int): 
			return item.custom_name.to_lower() == entity_name.to_lower()
	)
	if entity != null: 
		return entity.get_speaker_idle_sprite()
	return null
	
func get_speaker_talk_sprite(entity_name: String) -> Texture2D: 
	var entity: Entity = NodeTools.get_item_from_array(entities.entities, 
		func(item: Entity, _i: int): 
			return item.custom_name.to_lower() == entity_name.to_lower()
	)
	if entity != null: 
		return entity.get_speaker_talk_sprite()
	return null
	
	
func is_main_speaker(entity_name: String) -> bool: 
	for entity: Entity in main_speakers: 
		if entity.name.to_lower() == entity_name.to_lower(): 
			return true
	return false


func set_current_speaker_rect_texture(texture: Texture2D) -> void: 
	current_speaker_rect.texture = texture

