extends SaveableResource
class_name EcoQuestTask

signal started
signal completed

@export var description: String

@export var condition: EcoQuestTaskCondition
## If this hits the maximum, it will complete this task. 
#@export var counter: WorldEventPointCounter: 
	#set(value): 
		#counter = value
		#if !is_instance_valid(counter): 
			#return
		#counter.disabled = true
		#counter.counter.maximum_hit.connect(
			#_on_counter_maximum_hit
		#, CONNECT_ONE_SHOT
		#)

@export var hide_counter_in_gui: bool

var is_completed: bool: 
	set(value): 
		is_completed = value
		if is_completed: 
			completed.emit()


## Called by EcoQuest. 
func start(tree: SceneTree) -> void: 
	if condition: 
		condition.init(tree, self)
	started.emit()

#func _on_counter_maximum_hit(_value: float) -> void: 
	#is_completed = true
	
	
func _save_properties() -> PackedStringArray: 
	return [
		"is_completed", 
		"condition"
	]

func _to_string() -> String: 
	return "%s: <EcoQuestTask#%s>" % [description, get_instance_id()]


func get_counter() -> PointCounter: 
	if condition is EcoQuestTaskScriptCondition: 
		return condition.counter
	return null
	
	
