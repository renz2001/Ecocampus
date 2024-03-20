## The attempt to answer the quiz
extends Resource
class_name QuizAttempt

signal started

signal problem_attempt_completed(attempt: QuizProblemAttempt)

signal completed

@export var quiz: Quiz

var problem_attempts: Array[QuizProblemAttempt] = []

## The current problem
var current_problem_index: PointCounter

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


func _init() -> void: 
	current_problem_index = PointCounter.new()
	current_problem_index.minimum = 0
	current_problem_index.starting_value = 0
	current_problem_index.reset_after_maximum_exceeded = true
	current_problem_index.reset_after_minimum_exceeded = true


func start() -> void: 
	is_completed = false
	problem_attempts = _get_problem_attempts()
	current_problem_index.reset()
	current_problem_index.maximum = problem_attempts.size() - 1
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


func get_current_problem() -> QuizProblemAttempt: 
	return problem_attempts[current_problem_index.current]
	
	
func next_problem() -> void: 
	current_problem_index.increment()
	
	
func previous_problem() -> void: 
	current_problem_index.decrement()
	
	
