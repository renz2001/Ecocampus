## Resource that holds the problems, title and description of a Quiz
extends Resource
class_name Quiz


@export var title: String
@export var description: String
@export var problems: Array[QuizProblem]

@export var passing_score: int


func attempt() -> QuizAttempt: 
	var attempt: QuizAttempt = QuizAttempt.new(self)
	
	return attempt


func get_total_score() -> int: 
	var total: int = 0
	for problem: QuizProblem in problems: 
		total += problem.reward_points
	return total
	
	
