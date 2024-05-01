## The attempt to answer the quiz
extends Resource
class_name QuizAttempt

enum AttemptState {
	ANSWERING, 
	VICTORY, 
	LOST
}

signal started

signal state_changed(state: AttemptState)
signal problem_attempt_completed(attempt: QuizProblemAttempt)

signal completed

@export var quiz: Quiz
@export var state: AttemptState: 
	set(value): 
		state = value
		state_changed.emit(state)


var problem_attempts: Array[QuizProblemAttempt] = []

## The current problem
var current_problem_index: PointCounter

var score: int = 0: 
	get: 
		var count: int = 0
		for attempt: QuizProblemAttempt in problem_attempts: 
			count += int(attempt.points)
		return count

var is_completed: bool = false: 
	set(value): 
		is_completed = value
		if is_completed: 
			completed.emit()

var is_victory: bool: 
	get: 
		return problem_attempts.all(
			func(attempt: QuizProblemAttempt):
				return attempt.is_victory
		)

static func from_quiz(_quiz: Quiz) -> QuizAttempt: 
	var attempt: QuizAttempt = QuizAttempt.new()
	attempt.quiz = _quiz
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
	state = AttemptState.ANSWERING
	started.emit()


func _get_problem_attempts() -> Array[QuizProblemAttempt]: 
	var attempts: Array[QuizProblemAttempt] = []
	for problem: QuizProblem in quiz.problems: 
		var attempt: QuizProblemAttempt = problem.attempt()
		attempts.append(attempt)
		attempt.completed.connect(_on_problem_attempt_completed.bind(attempt))
		
	return attempts


func has_passed_attempt() -> bool: 
	return score >= quiz.passing_score
	
	
func complete() -> void: 
	if is_completed: 
		push_error("QuizAttempt: %s is already completed. " % quiz.title)
		return
	if is_victory: 
		state = AttemptState.VICTORY
		quiz.victory_counter += 1
	else: 
		state = AttemptState.LOST
		
	is_completed = true


func is_all_problems_completed() -> bool: 
	return problem_attempts.all(
		func(item): 
			var attempt: QuizProblemAttempt = item
			return attempt.is_completed
	)


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
	
	
