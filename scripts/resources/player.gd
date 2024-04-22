@tool
extends Entity
class_name Player

@export var default_cosmetic: Cosmetic
@export var current_cosmetic: Cosmetic


func get_current_cosmetic() -> Cosmetic: 
	if current_cosmetic == null: 
		return default_cosmetic
	return current_cosmetic
	
	
