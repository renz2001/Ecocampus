extends GUI
class_name QuizAttemptGUI


@export var quiz_attempt: QuizAttempt: 
	set(value): 
		quiz_attempt = value
		if !is_node_ready(): 
			await ready
			
		quiz_attempt.completed.connect(
			_on_quiz_attempt_completed
		)
		title.text = quiz_attempt.quiz.title
		end_title.text = quiz_attempt.quiz.title
		description.text = quiz_attempt.quiz.description

@export var problem_page: QuizProblemPage
@export var title: Label
@export var end_title: Label
@export var description: Label

@export var score: FormattedLabel
@export var wrong: Label
@export var problem_page_router: PageRouter


var quiz: Quiz


func start(q: Quiz) -> void: 
	quiz = q
	quiz_attempt = quiz.attempt()


func _on_quiz_attempt_completed() -> void: 
	print(quiz_attempt.score)
	score.input([str(quiz_attempt.score), str(quiz_attempt.quiz.maximum_score)])


func _on_play_pressed() -> void: 
	quiz_attempt.start()
	problem_page.quiz_attempt = quiz_attempt


func _on_exit_pressed() -> void: 
	GUIManager.set_gui_active(self, false)


func _on_quiz_problem_page_quiz_completed() -> void:
	problem_page_router.route()


#func _activated() -> void: 
	#GameManager.enable_player_on_playing_entered = false
#
#
#func _deactivated() -> void: 
	#GameManager.enable_player_on_playing_entered = true
	
	
