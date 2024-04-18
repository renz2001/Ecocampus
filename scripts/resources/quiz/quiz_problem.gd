extends Resource
class_name QuizProblem

@export var question: String

@export var correct_answer: String

@export var wrong_answers: Array[String]

@export var reward_points: int = 1


func attempt() -> QuizProblemAttempt: 
	var _attempt: QuizProblemAttempt = QuizProblemAttempt.new(self)
	return _attempt


func get_answers() -> Array[String]: 
	var array: Array[String] = wrong_answers.duplicate()
	array.append(correct_answer)
	array.shuffle()
	return array
	
	
func is_correct_answer(value: String) -> bool: 
	return value.to_snake_case() == correct_answer.to_snake_case() 
	
	
