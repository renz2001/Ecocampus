## An extended quest for this game
@tool
extends Quest
class_name EcoQuest

signal task_completed(task: EcoQuestTask)

@export var percentage_description: String
@export var tasks: Array[EcoQuestTask]: 
	set(value): 
		tasks = value
		for task: EcoQuestTask in tasks: 
			task.completed.connect(func(): task_completed.emit(task))
			
## Optional, leave null if not wanted. Unlocks this achievement when finished 
@export var on_complete_unlock_achievement: Achievement

var percentage_description_format: StringFormatter

var completed_percentage: Percentage: 
	get: 
		#print(Percentage.new(completed_tasks_count, tasks_count))
		return Percentage.new(completed_tasks_count, tasks_count)

var tasks_count: int:
	get: 
		return tasks.size()
		
var completed_tasks_count: int: 
	get: 
		var count: int = 0
		for task: EcoQuestTask in tasks: 
			if task.is_completed: 
				count += 1
		return count


func _init() -> void: 
	percentage_description_format = StringFormatter.new()
	percentage_description_format.format = "%s: %s/%s"
	
	
func update() -> void: 
	var logic_gate: LogicGate = LogicGate.new()
	
	for task: EcoQuestTask in tasks: 
		logic_gate.conditions.append(task.completed)
		
	if logic_gate.is_true(): 
		objective_completed = true


func display_achievement() -> void: 
	AchievementUnlockedScreen.display(on_complete_unlock_achievement)
	
	
func _to_string() -> String: 
	return "%s: <EcoQuest#%s>" % [quest_name, get_instance_id()]
