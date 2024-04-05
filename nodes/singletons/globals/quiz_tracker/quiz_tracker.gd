extends Node
class_name QuizTracker

signal quiz_started(quiz: Quiz)


func start_quiz(quiz: Quiz) -> void: 
	QuizScreen.display(quiz)
	quiz_started.emit(quiz)
	
