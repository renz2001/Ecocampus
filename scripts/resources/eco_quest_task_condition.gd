## Used by EcoQuestTask
## This works by putting it into and EcoQuestTask and then the start() will activate this condition. 
extends SaveableResource
class_name EcoQuestTaskCondition

var task: EcoQuestTask
var tree: SceneTree

func init(_tree: SceneTree, _task: EcoQuestTask) -> void: 
	task = _task
	tree = _tree
	
	
