## The attempt to answer the quiz
extends Resource
class_name QuizAttempt

signal started

signal problem_attempt_completed(attempt: QuizProblemAttempt)

signal completed

@export var quiz: Quiz

var problem_attempts: Array[QuizProblemAttempt] = []

var score: int = 0: 
	get: 
		var count: int = 0
		for attempt: QuizProblemAttempt in problem_attempts: 
			count += attempt.points
		return count

var is_completed: bool = false: 
	set(value): 
		is_completed = value
		if is_completed: 
			completed.emit()


static func from_quiz(quiz: Quiz) -> QuizAttempt: 
	var attempt: QuizAttempt = QuizAttempt.new()
	attempt.quiz = quiz
	return attempt


func start() -> void: 
	is_completed = false
	problem_attempts = _get_problem_attempts()
	started.emit()


func _get_problem_attempts() -> Array[QuizProblemAttempt]: 
	var attempts: Array[QuizProblemAttempt] = []
	for problem: QuizProblem in quiz.problems: 
		var attempt: QuizProblemAttempt = problem.attempt()
		attempts.append(attempt)
		attempt.completed.connect(_on_problem_attempt_completed.bind(attempt))
		
	return attempts


func has_passed_attempt() -> bool: 
	return quiz.passing_score >= score
	
	
func complete() -> void: 
	if is_completed: 
		push_error("QuizAttempt: %s is already completed. " % quiz.title)
		return
	is_completed = true


func is_all_problems_completed() -> bool: 
	var problem_attempts_size: int = problem_attempts.size()
	var completed_count: int = 0
	for attempt: QuizProblemAttempt in problem_attempts: 
		if attempt.is_completed: 
			completed_count += 1
	if completed_count == problem_attempts_size: 
		return true
	return false


func _on_problem_attempt_completed(attempt: QuizProblemAttempt) -> void: 
	if is_all_problems_completed(): 
		complete()
	problem_attempt_completed.emit(attempt)
