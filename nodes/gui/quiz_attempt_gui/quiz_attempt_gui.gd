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

@export var problem_pages: QuizProblemPages
@export var title: Label
@export var description: Label

@export var score: LabelPresetSetter
@export var wrong: Label


func _on_quiz_attempt_completed() -> void: 
	score.set_text([str(quiz_attempt.score), str(quiz_attempt.quiz.maximum_score)])


func _on_play_pressed() -> void: 
	quiz_attempt.start()
	problem_pages.quiz_attempt = quiz_attempt


func _on_exit_pressed() -> void:
	quiz_attempt.finish()
	GUIManager.set_gui_active(self, false)
