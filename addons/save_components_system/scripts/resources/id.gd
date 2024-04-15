@tool
extends SaveableResource
class_name ID

@export var value: String


func _init() -> void: 
	if ResourceUID.has_id(int(value)): 
		return
	value = str(ResourceUID.create_id())


static func use_custom_id(custom_id: String) -> ID: 
	var id: ID = ID.new()
	id.value = custom_id
	return id


func _save_properties() -> PackedStringArray: 
	return [
		"value"
	]
	
	
#func load_data(data: Dictionary) -> void: 
	#var properties: PackedStringArray = data.keys()
	#for property in properties: 
		#self.set(property, data[property])

