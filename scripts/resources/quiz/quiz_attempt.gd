## The attempt to answer the quiz
extends Resource
class_name QuizAttempt

@export var quiz: Quiz

var problem_attempts: Array[QuizProblemAttempt]

var score: int = 0

var finished: bool = false


func _init(_quiz: Quiz) -> void: 
	quiz = _quiz


func start() -> void: 
	problem_attempts = _get_problem_attempts()


func _get_problem_attempts() -> Array[QuizProblemAttempt]: 
	var attempts: Array[QuizProblemAttempt] = []
	for problem: QuizProblem in quiz.problems: 
		attempts.append(problem.attempt())
	return attempts
	
	
func calculate_total_score() -> void: 
	score = 0
	for attempt: QuizProblemAttempt in problem_attempts: 
		score += attempt.points
	
	
func has_passed_attempt() -> bool: 
	return quiz.passing_score >= score
	
	
func finish() -> void: 
	finished = true

