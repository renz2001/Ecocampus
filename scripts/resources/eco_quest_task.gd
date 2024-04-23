extends SaveableResource
class_name EcoQuestTask

signal completed

@export var description: String

@export var condition: EcoQuestTaskCondition
## If this hits the maximum, it will complete this task. 
@export var counter: WorldEventPointCounter: 
	set(value): 
		counter = value
		if !is_instance_valid(counter): 
			return
		counter.disabled = true
		counter.counter.maximum_hit.connect(
			_on_counter_maximum_hit
		, CONNECT_ONE_SHOT
		)

### Callable() -> bool
#var complete_condition: Callable 

var is_completed: bool: 
	set(value): 
		is_completed = value
		if is_completed: 
			completed.emit()


## Called by EcoQuest. 
func start(tree: SceneTree) -> void: 
	counter.disabled = false
	# TODO: Have not properly implemented yet. 
	if condition: 
		condition.init(tree, self)


func _on_counter_maximum_hit(_value: float) -> void: 
	is_completed = true
	
	
func _save_properties() -> PackedStringArray: 
	return [
		"is_completed", 
		"counter"
	]

func _to_string() -> String: 
	return "%s: <EcoQuestTask#%s>" % [description, get_instance_id()]
