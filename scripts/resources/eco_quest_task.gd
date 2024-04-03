@tool
extends Resource
class_name EcoQuestTask


@export var description: String

@export var counter: PointCounter

### Callable() -> bool
#var complete_condition: Callable 

var completed: bool


func _init() -> void: 
	counter.maximum_hit.connect(
		func(): 
			completed = true
	)
	
	
