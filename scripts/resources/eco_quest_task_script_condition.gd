extends EcoQuestTaskCondition
class_name EcoQuestTaskScriptCondition

@export var scene: PackedScene
@export var maximum_points: int = 1

var counter: PointCounter


func init(tree: SceneTree, _task: EcoQuestTask) -> void: 
	super.init(tree, _task)
	counter = PointCounter.new()
	counter.starting_value = 0
	counter.when_maximum_stay = true
	counter.maximum = maximum_points
	var instance: EcoQuestTaskScriptConditionNode = scene.instantiate()
	tree.current_scene.add_child(instance)
	instance.init(_task, self)


func _save_properties() -> PackedStringArray: 
	return [
		"counter"
	]
	
	
