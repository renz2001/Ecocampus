extends NodeComponent
class_name EcoQuestTaskScriptConditionNode

var task: EcoQuestTask
var condition: EcoQuestTaskScriptCondition


func init(_task: EcoQuestTask, _condition: EcoQuestTaskScriptCondition) -> void: 
	task = _task
	condition = _condition
	_initialized()


func _initialized() -> void: 
	pass
	
	
