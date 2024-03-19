extends Resource
class_name QuizProblemAttempt

signal completed

var problem: QuizProblem

var is_completed: bool: 
	set(value): 
		is_completed = value
		if is_completed: 
			completed.emit()
			
var points: float


func _init(_problem: QuizProblem) -> void: 
	problem = _problem


func submit_answer(ans: String) -> void: 
	if problem.is_correct_answer(ans): 
		points = problem.reward_points
		
	is_completed = true

	
	
