extends PageRouterContainer
class_name QuizProblemPages


@export var quiz: QuizAttempt: 
	set(value): 
		quiz = value
		for attempt: QuizProblemAttempt in quiz.problem_attempts: 
			QuizProblemPage.create(self, attempt)
