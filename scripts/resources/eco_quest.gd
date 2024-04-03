## An extended quest for this game
@tool
extends Quest
class_name EcoQuest


@export var percentage_description: String
@export var tasks: Array[EcoQuestTask]

var percentage_description_format: StringFormatter

var completed_percentage: Percentage: 
	get: 
		return Percentage.new(completed_tasks_count, tasks_count)

var tasks_count: int:
	get: 
		return tasks.size()
		
var completed_tasks_count: int: 
	get: 
		var count: int = 0
		for task: EcoQuestTask in tasks: 
			if task.completed: 
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


