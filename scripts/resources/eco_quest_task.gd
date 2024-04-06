extends Resource
class_name EcoQuestTask

signal completed

@export var description: String

## If this hits the maximum, it will complete this task. 
@export var counter: WorldEventPointCounter: 
	set(value): 
		counter = value
		if !is_instance_valid(counter): 
			return
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


func _on_counter_maximum_hit(_value: float) -> void: 
	is_completed = true
	
	
