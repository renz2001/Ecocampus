extends Resource
class_name SaveableResource

## In order for you to save properties with custom resources, in the _init(), define properties (var) some items that you want to save. 
## func _init()
## 	properties = ["scene_file", "items"] 
## 	super._init() 

var save: PropertiesToSave


func _init() -> void: 
	_save()
	
	
func _save() -> void: 
	if Engine.is_editor_hint(): 
		return
	save = PropertiesToSave.from(_save_properties())


## Virtual Function
## Return the list of properties writting in string here that you want to save. 
func _save_properties() -> PackedStringArray: 
	#if Engine.is_editor_hint(): 
		#return
	#save = PropertiesToSave.from_resource(self, properties)
	return []
	
	
func to_dict() -> Dictionary: 
	return save.to_dict(self)
