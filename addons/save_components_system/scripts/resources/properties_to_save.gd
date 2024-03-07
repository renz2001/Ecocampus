## Abstract class for types of save data
extends Resource
class_name PropertiesToSave


## The properties that will be saved. 
@export var properties: PackedStringArray

#@export var additional_node_save_data: Array[FollowerSaveComponent]


#func to_json() -> JSON: 
	#var json: JSON = JSON.new()
	#var error = json.parse(JSON.stringify(data))
	#if error == OK:
		#return json
	#return null
#

static func from(props: PackedStringArray) -> PropertiesToSave: 
	var save: PropertiesToSave = PropertiesToSave.new()
	save.properties = props
	return save
	
	
func to_dict(from_object: Object) -> Dictionary: 
	var data: Dictionary = {}
	for property: String in properties: 
		var value = from_object.get(property)
		if value is SaveableResource: 
			data[property] = value.to_dict()
		#elif value is PackedScene: 
			#data[property] = value.get
		elif value is Resource: 
			push_error("%s is not a SaveableResource, from object: %s" % [self.resource_name, from_object])
		else: 
			data[property] = value
	return data

