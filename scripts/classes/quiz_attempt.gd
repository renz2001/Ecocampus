extends Resource
class_name QuizAttempt

@export var quiz: Quiz

@export var qualifications: Array[QuizAttemptQualifier]


func has_passed_attempt() -> bool: 
	return (qualifications.back() as QuizAttemptQualifier).has_passed_attempt()
	
	
