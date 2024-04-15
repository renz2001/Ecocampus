# TODO: (Undecided)
extends NodeComponent
class_name GlobalsSaveComponent

@export var autoload_name: String
@export var data: PropertiesToSave
@export var master_save_component: MasterSaveComponent


func to_dict() -> Dictionary: 
	var dict: Dictionary
	var autoload: Node = NodeTools.get_autoload(self, autoload_name)
	
	dict = {
		str(autoload.get_path()): data.to_dict(autoload)
	}
	
	return dict
