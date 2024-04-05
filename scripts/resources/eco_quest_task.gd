extends Resource
class_name EcoQuestTask


@export var description: String

## If this hits the maximum, it will complete this task. 
@export var counter: WorldEventPointCounter: 
	set(value): 
		counter = value
		if !is_instance_valid(counter): 
			return
		counter.maximum_hit.connect(
			func(): 
				completed = true
		, CONNECT_ONE_SHOT
		)

### Callable() -> bool
#var complete_condition: Callable 

var completed: bool

