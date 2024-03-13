extends Resource
class_name Quiz


@export var title: String
@export var description: String
@export var problems: Array[QuizProblem]

@export var passing_score: int


func get_total_score() -> int: 
	var total: int = 0
	for problem: QuizProblem in problems: 
		total += problem.reward_points
	return total
	
	
