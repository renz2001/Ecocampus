extends SaveableResource
class_name Entity

signal name_changed
signal speaker_sprite_changed
signal gender_changed

@export var custom_name: String: 
	get: 
		if custom_name.is_empty(): 
			return name
		return custom_name

@export var name: String: 
	set(value): 
		name = value
		name_changed.emit()


@export var male_speaker_idle_sprite: Texture2D: 
	set(value): 
		male_speaker_idle_sprite = value
		speaker_sprite_changed.emit()
		
		
@export var male_speaker_talk_sprite: Texture2D: 
	set(value): 
		male_speaker_talk_sprite = value
		speaker_sprite_changed.emit()
		
		
@export var female_speaker_idle_sprite: Texture2D: 
	set(value): 
		female_speaker_idle_sprite = value
		speaker_sprite_changed.emit()
		
		
@export var female_speaker_talk_sprite: Texture2D: 
	set(value): 
		female_speaker_talk_sprite = value
		speaker_sprite_changed.emit()
		
		
@export var gender: GlobalEnums.Gender: 
	set(value): 
		gender = value
		gender_changed.emit()
	
	
@export var group: String = "Entity"
	
	
func get_speaker_idle_sprite() -> Texture2D: 
	if gender == GlobalEnums.Gender.FEMALE: 
		return female_speaker_idle_sprite
	return male_speaker_idle_sprite
	
	
func get_speaker_talk_sprite() -> Texture2D: 
	if gender == GlobalEnums.Gender.FEMALE: 
		return female_speaker_talk_sprite
	return male_speaker_talk_sprite
	
	
func get_node(tree: SceneTree) -> EntityNode: 
	return NodeTools.get_item_from_array(
		tree.get_nodes_in_group(group), 
		func(entity: EntityNode, _i): 
			return entity.data.name == name
	)
	
	
func _save_properties() -> PackedStringArray: 
	return [
		"custom_name"
	]


func _to_string() -> String: 
	return "%s: <Entity#%s>(custom_name:%s)" % [name, get_instance_id(), custom_name]

