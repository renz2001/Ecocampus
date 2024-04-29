@tool
extends Entity
class_name Player

signal current_cosmetic_changed

@export var default_cosmetic: Cosmetic

@export var current_cosmetic: Cosmetic: 
	set(value): 
		current_cosmetic = value
		current_cosmetic_changed.emit()
		
	get: 
		if current_cosmetic == null: 
			return default_cosmetic
		return current_cosmetic


func is_equipped() -> bool: 
	return current_cosmetic != default_cosmetic


func equip_cosmetic(cosmetic: Cosmetic) -> void: 
	current_cosmetic = cosmetic


func unequip_cosmetic() -> void: 
	current_cosmetic = default_cosmetic
	

func _save_properties() -> PackedStringArray: 
	var arr: PackedStringArray = [
		"current_cosmetic"
	]
	arr.append_array(super._save_properties())
	
	return arr
