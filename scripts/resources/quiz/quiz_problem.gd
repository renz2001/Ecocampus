extends Resource
class_name QuizProblem

@export var question: String

@export var correct_answer: String

@export var wrong_answers: Array[String]

@export var reward_points: int


func attempt() -> QuizProblemAttempt: 
	var attempt: QuizProblemAttempt = QuizProblemAttempt.new(self)
	
	return attempt


func get_answers() -> PackedStringArray: 
	var array: Array[String] = wrong_answers
	array.append(correct_answer)
	array.shuffle()
	return array
	
	
func is_correct_answer(value: String) -> bool: 
	return value.to_snake_case() == correct_answer.to_snake_case() 
	
	
