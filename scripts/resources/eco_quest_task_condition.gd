## Used by EcoQuestTask
## This works by putting it into and EcoQuestTask and then the start() will activate this condition. 
extends SaveableResource
class_name EcoQuestTaskCondition

var task: EcoQuestTask
var tree: SceneTree
var initiazlied: bool


func init(_tree: SceneTree, _task: EcoQuestTask) -> void: 
	task = _task
	tree = _tree
	initiazlied = true
	
	
func _to_string() -> String: 
	return "%s: <EcoQuestTaskCondition#%s>" % [task, get_instance_id()]
