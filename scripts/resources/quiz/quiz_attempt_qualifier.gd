extends Resource
class_name QuizAttemptQualifier

var quiz: Quiz

var score: int = 0

var finished: bool = false


func has_passed_attempt() -> bool: 
	return quiz.passing_score >= score
	
	
func finish() -> void: 
	finished = true

