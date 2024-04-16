extends EntityNode
class_name PickuppableEntity


func _ready() -> void: 
	super._ready() 
	interact_description.texts = [
		data.name, 
		GlobalVariables.get_enum_name(ItemEntity.Type, data.type), 
		data.environmental_impact
	]
