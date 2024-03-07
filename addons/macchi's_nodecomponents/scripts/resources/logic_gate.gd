extends Resource
class_name LogicGate

enum Logic {
	AND, 
	OR
}

@export var logic_gate: Logic = Logic.AND

var conditions: Array[bool] = []


func resize(size: int) -> void: 
	conditions.resize(size)
	
	
func fill(booleans: bool) -> void: 
	conditions.fill(booleans)


func is_true() -> bool: 
	var val: bool = check_condition()
	if val: 
		return true
	return false


func is_false() -> bool: 
	var val: bool = check_condition()
	if val: 
		return false
	return true


func check_condition() -> bool: 
	match logic_gate: 
		Logic.AND: 
			if !conditions.has(false): 
				return true 
		Logic.OR: 
			if conditions.has(true): 
				return true
	return false
