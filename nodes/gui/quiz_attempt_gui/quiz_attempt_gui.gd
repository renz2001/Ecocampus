extends GUI
class_name QuizAttemptGUI


@export var quiz: Quiz: 
	set(value): 
		quiz = value

@export var pages: PageRouterContainer
@export var problem_pages: PageRouterContainer


