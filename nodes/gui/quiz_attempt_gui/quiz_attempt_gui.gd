extends GUI
class_name QuizAttemptGUI


@export var quiz_attempt: QuizAttempt: 
	set(value): 
		quiz_attempt = value
		if !is_node_ready(): 
			await ready
			
		quiz_attempt.completed.connect(
			_on_quiz_attempt_completed
		, CONNECT_ONE_SHOT
		)
		title.text = quiz_attempt.quiz.title
		description.text = quiz_attempt.quiz.description

@export var problem_page: QuizProblemPage
@export var title: Label
@export var description: Label

@export var score: LabelPresetSetter
@export var wrong: Label
@export var problem_page_router: PageRouter

func _on_quiz_attempt_completed() -> void: 
	score.set_text([str(quiz_attempt.score), str(quiz_attempt.quiz.maximum_score)])


func _on_play_pressed() -> void: 
	quiz_attempt.start()
	problem_page.quiz_attempt = quiz_attempt


func _on_exit_pressed() -> void: 
	GUIManager.set_gui_active(self, false)


func _on_quiz_problem_page_quiz_completed() -> void:
	problem_page_router.route()
