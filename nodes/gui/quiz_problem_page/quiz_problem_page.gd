@tool
extends GUI
class_name QuizProblemPage

signal correctly_answered

@export var problem_attempt: QuizProblemAttempt: 
	set(value): 
		problem_attempt = value
		if !is_node_ready(): 
			await ready
		if !is_instance_valid(problem_attempt): 
			return
		
		question_label.text = problem_attempt.problem.question
		
		var p_answers: Array[String] = problem_attempt.problem.get_answers()
		answer_a.label.text = p_answers[0]
		answer_b.label.text = p_answers[1]
		answer_c.label.text = p_answers[2]
		answer_d.label.text = p_answers[3]

@export var question_label: Label

@export var answers: GridContainer

@export var answer_a: TextureButtonPlus
@export var answer_b: TextureButtonPlus
@export var answer_c: TextureButtonPlus
@export var answer_d: TextureButtonPlus

@export var page_router: PageRouter


static func create(parent: QuizProblemPages, problem_attempt: QuizProblemAttempt) -> QuizProblemPage: 
	var gui: QuizProblemPage = GUICollection.quiz_problem_page.instantiate()
	parent.add_child(gui)
	gui.problem_attempt = problem_attempt
	gui.page_router.page_router_container = parent
	return gui


func _ready() -> void: 
	for button: TextureButtonPlus in answers.get_children(): 
		button.pressed.connect(_on_answer_pressed.bind(button))
		
		
func _on_answer_pressed(button: TextureButtonPlus) -> void: 
	problem_attempt.submit_answer(button.label.text)
	page_router.route()

