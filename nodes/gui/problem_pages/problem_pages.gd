extends PageRouterContainer


@export var quiz: Quiz: 
	set(value): 
		quiz = value
		for problem: QuizProblem in quiz.problems: 
			QuizProblemPage.create(self, problem)
