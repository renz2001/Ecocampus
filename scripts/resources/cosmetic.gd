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
		

@export var male_icon: Texture2D
@export var female_icon: Texture2D

@export var state: CosmeticState: 
	set(value): 
		state = value 
		if state == CosmeticState.UNLOCKED: 
			unlocked.emit()

@export var male_sprite: Texture2D
@export var female_sprite: Texture2D

@export var medals_required: int = 1

## Should only be ticked true for one cosmetic. 
@export var is_default: bool: 
	set(value): 
		is_default = value
		if is_default: 
			state = CosmeticState.UNLOCKED
		else: 
			state = CosmeticState.LOCKED


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
	#printerr("medals: %s, required: %s" % [medals, medals_required])
	if medals >= medals_required: 
		state = CosmeticState.UNLOCKED
	
	
func _save_properties() -> PackedStringArray: 
	return [
		"state"
	]


func is_unlocked() -> bool: 
	return state == CosmeticState.UNLOCKED


func reset() -> void: 
	state == CosmeticState.LOCKED
	
	
