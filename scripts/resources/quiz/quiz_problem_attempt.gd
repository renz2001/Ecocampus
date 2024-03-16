extends Resource
class_name QuizProblemAttempt

var problem: QuizProblem

var completed: bool
var points: float


func _init(_problem: QuizProblem) -> void: 
	problem = _problem


func submit_answer(ans: String) -> void: 
	if problem.is_correct_answer(ans): 
		points = problem.reward_points
		
	completed = true

	
	
