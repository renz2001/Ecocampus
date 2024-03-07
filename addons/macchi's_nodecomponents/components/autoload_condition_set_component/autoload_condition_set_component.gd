extends ConditionalSetPropertyComponent
class_name AutoloadConditionSetComponent

@export var autoload_conditions: Array[AutoloadConditionSetCondition]


func _condition() -> bool: 
	for condition: AutoloadConditionSetCondition in autoload_conditions: 
		var property: bool = false
		var autoload: Node = get_node("/root/%s" % condition.node)
		if condition.from_method: 
			property = Callable(autoload, condition.property).call() 
		else: 
			property = autoload.get(condition.property)
		if condition.if_false: 
			return !property
		else: 
			return property
	return false

