extends Node
class_name QuizTracker


func start_quiz(quiz: Quiz) -> void: 
	var gui: QuizScreen = QuizScreen.display(quiz)
	
