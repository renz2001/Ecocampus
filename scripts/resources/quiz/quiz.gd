## Resource that holds the problems, title and description of a Quiz
extends Resource
class_name Quiz

signal victory

@export var title: String
@export var description: String = "Pass this assesment and win an achievement!"
@export var problems: Array[QuizProblem]
@export var on_victory_unloch_achievement: Achievement

## Percentage of the passing score. 
@export_range(0, 1) var passing_score_percentage: float = 1

var victory_counter: int = 0: 
	set(value): 
		victory_counter = value
		victory.emit()


var maximum_score: int: 
	get:
		var count: int = 0
		for problem: QuizProblem in problems: 
			count += problem.reward_points
		return count

var passing_score: float: 
	get: 
		return maximum_score * passing_score_percentage

func attempt() -> QuizAttempt: 
	var _attempt: QuizAttempt = QuizAttempt.from_quiz(self)
	return _attempt
	
	
func _to_string() -> String: 
	return "%s: <QuizAttempt#%s>" % [title, get_instance_id()]
