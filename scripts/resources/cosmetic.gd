@tool
extends Resource
class_name Cosmetic

enum CosmeticState {
	LOCKED, 
	UNLOCKABLE, 
	UNLOCKED, 
}

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

@export var unlock_points_requirement: int

@export var male_icon: Texture2D
@export var female_icon: Texture2D

@export var state: CosmeticState

@export var male_sprite: Texture2D
@export var female_sprite: Texture2D


func get_icon(gender: GlobalEnums.Gender) -> Texture2D: 
	match gender: 
		GlobalEnums.Gender.MALE: 
			return male_icon
		GlobalEnums.Gender.FEMALE: 
			return female_icon
	return null
	
