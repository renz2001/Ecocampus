@tool
extends GUI
class_name QuizProblemPage

signal correctly_answered

@export var problem_attempt: QuizProblemAttempt: 
	set(value): 
		problem_attempt = value
		question_label.text = problem_attempt.problem.question
		var p_answers: Array[String] = problem_attempt.problem.get_answers()
		answer_a.text = p_answers[0]
		answer_b.text = p_answers[1]
		answer_c.text = p_answers[2]
		answer_d.text = p_answers[3]

@export var question_label: Label

@export var answers: GridContainer

@export var answer_a: Button
@export var answer_b: Button
@export var answer_c: Button
@export var answer_d: Button


static func create(parent: Node, problem: QuizProblemAttempt) -> QuizProblemPage: 
	var gui: QuizProblemPage = GUICollection.quiz_problem_page.instantiate()
	parent.add_child(gui)
	gui.problem = problem
	return gui


func _ready() -> void: 
	for button: TextureButtonPlus in answers.get_children(): 
		button.pressed.connect(_on_answer_pressed.bind(button))
		
		
func _on_answer_pressed(button: TextureButtonPlus) -> void: 
	problem_attempt.submit_answer(button.label.text)

