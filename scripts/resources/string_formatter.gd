extends Resource
class_name StringFormatter

@export var format: String = "%s"


func input(val: Array[String]) -> String: 
	return format % val
	
	
