extends EcoQuestTaskCondition
class_name EcoQuestTaskScriptCondition

#@export var scene: PackedScene
@export var maximum_points: int = 1: 
	set(value): 
		maximum_points = value
		counter.maximum = maximum_points

## When this hits it's maximum, it will complete the task. 
var counter: PointCounter

func _init() -> void: 
	super._init()
	counter = PointCounter.new()
	counter.starting_value = 0
	counter.when_maximum_stay = true
	counter.maximum = maximum_points


func init(_tree: SceneTree, _task: EcoQuestTask) -> void: 
	super.init(_tree, _task)
	if counter.maximum_hit.is_connected(_on_counter_maximum_hit): 
		counter.maximum_hit.connect(_on_counter_maximum_hit, CONNECT_ONE_SHOT)
	#var instance: EcoQuestTaskScriptConditionNode = scene.instantiate()
	#tree.current_scene.add_child(instance)
	#instance.init(_task, self)
	_initialized()

func _on_counter_maximum_hit(_value: float) -> void: 
	task.is_completed = true
	_finished()


func _initialized() -> void: 
	pass
	
	
## Works as sort of a destructor for this. Is called when task is finished. 
func _finished() -> void: 
	pass
	
	
func _save_properties() -> PackedStringArray: 
	return [
		"counter"
	]
	
	
