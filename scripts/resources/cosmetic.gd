@tool
extends SaveableResource
class_name Cosmetic

enum CosmeticState {
	LOCKED, 
	UNLOCKED, 
}

signal unlocked

@export var name: String

@export var male_alias: String: 
	get: 
		if male_alias.is_empty(): 
			return name
		return male_alias
		
@export var female_alias: String: 
	get: 
		if female_alias.is_empty(): 
			return name
		return female_alias

@export var is_unlocked: bool: 
	set(value): 
		is_unlocked = value
		if is_unlocked: 
			unlocked.emit()

@export var male_icon: Texture2D
@export var female_icon: Texture2D

@export var state: CosmeticState

@export var male_sprite: Texture2D
@export var female_sprite: Texture2D

@export var medals_required: int = 1

func get_icon(gender: GlobalEnums.Gender) -> Texture2D: 
	match gender: 
		GlobalEnums.Gender.MALE: 
			return male_icon
		GlobalEnums.Gender.FEMALE: 
			return female_icon
	return null
	
	
func get_current_name(gender: GlobalEnums.Gender) -> String: 
	match gender: 
		GlobalEnums.Gender.MALE: 
			return male_alias
		GlobalEnums.Gender.FEMALE: 
			return female_alias
	return ""
	
	
func unlock(medals: int) -> void: 
	if medals == medals_required: 
		is_unlocked = true
	
	
func _save_properties() -> PackedStringArray: 
	return [
		"unlocked", 
		"state"
	]
