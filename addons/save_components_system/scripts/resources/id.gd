@tool
extends Resource
class_name ID

@export var generate_id: bool: 
	set(val): 
		value = ResourceUID.create_id()
		
@export var value: int

var initialized: bool = false


static func create() -> ID: 
	var id: ID = ID.new()
	id.value = ResourceUID.create_id()
	return id


func save_data() -> Dictionary: 
	var data: Dictionary = {
		"value": value
	}
	return data
	
	
#func load_data(data: Dictionary) -> void: 
	#var properties: PackedStringArray = data.keys()
	#for property in properties: 
		#self.set(property, data[property])

