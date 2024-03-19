extends PageRouterContainer
class_name QuizProblemPages


@export var quiz_attempt: QuizAttempt: 
	set(value): 
		quiz_attempt = value
		
		if quiz_attempt == null: 
			return
			
		for child: Node in get_children(): 
			child.queue_free()
			
		for attempt: QuizProblemAttempt in quiz_attempt.problem_attempts: 
			QuizProblemPage.create(self, attempt)
