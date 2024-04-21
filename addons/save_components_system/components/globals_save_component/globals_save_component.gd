# TODO: (Undecided)
extends NodeComponent
class_name GlobalsSaveComponent

@export var autoload_name: String
@export var data: PropertiesToSave
@export var master_save_component: MasterSaveComponent


func to_dict() -> Dictionary: 
	var dict: Dictionary
	var autoload: Node = NodeTools.get_autoload(self, autoload_name)
	print(autoload)
	master_save_component.node = autoload

	return master_save_component.to_dict()


func load_dict(dict: Dictionary) -> void: 
	master_save_component.load_dict(dict)
	
	
