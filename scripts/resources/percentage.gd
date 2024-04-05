extends Resource
class_name Percentage

## This is formatted like 70(int)/100(int)
@export var value: int
@export var maximum: int


func _init(_value: int, _maximum: int) -> void: 
	value = _value
	maximum = _maximum


func to_float() -> float: 
	return float(value) / float(maximum)


func to_percentage_number() -> int: 
	return to_float() * 100
	
	
#func float_to_string(value: float) -> String: 
	#return "%s%" % [value * maximum]


func _to_string() -> String: 
	return "%s%%" % [to_percentage_number()]
	
	
