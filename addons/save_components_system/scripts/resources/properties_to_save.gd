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
		if value is Vector2: 
			data[property] = {
				"x": value.x, 
				"y": value.y
			}
		elif value is Array: 
			for item in value: 
				if item is SaveableResource: 
					data[property] = []
					data[property].append(item.to_dict())
					pass
		elif value is Resource: 
			if ResourceLoader.exists(value.resource_path): 
				data[property] = value.resource_path
			else: 
				push_error("%s is not a SaveableResource and does not have a resource path. From object: %s" % [value.resource_path, from_object])
		else: 
			data[property] = value
	return data


static func load_dict_to_object(obj: Object, dict: Dictionary) -> void: 
	for property: String in dict.keys(): 
		var value = dict[property]
		if value is String: 
			if ResourceLoader.exists(value): 
				obj.set(property, load(value))
			else: 
				obj.set(property, JSON.parse_string(value))
		if value is Dictionary: 
			if value.has("x") && value.has("y"): 
				obj.set(property, Vector2(value["x"], value["y"]))
			for value_prop: String in value.keys(): 
				var value_value = value[value_prop]
				obj.set(value_prop, value_value)
		else: 
			#print(obj.get(property))
			obj.set(property, value)
			#printerr(obj.get(property))
