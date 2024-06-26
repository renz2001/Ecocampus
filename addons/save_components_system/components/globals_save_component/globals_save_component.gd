extends NodeComponent
class_name GlobalsSaveComponent

@export var autoload_name: String
@export var data: PropertiesToSave
@export var master_save_component: MasterSaveComponent


func _ready() -> void: 
	var autoload: Node = NodeTools.get_autoload(self, autoload_name)
	master_save_component.node = autoload
	master_save_component.data = data
	

func to_dict() -> Dictionary: 
	var dict: Dictionary
	#printerr("save: ", master_save_component.to_dict())
	return master_save_component.to_dict()


func load_dict(dict: Dictionary) -> void: 
	master_save_component.load_dict(dict)
	
	
