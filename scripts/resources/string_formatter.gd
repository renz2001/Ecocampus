extends Resource
class_name StringFormatter

@export_multiline var format: String = "%s"


func input(val: Array[String]) -> String: 
	return format % val
	
	
