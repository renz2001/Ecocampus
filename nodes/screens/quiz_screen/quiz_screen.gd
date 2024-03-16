extends GUI
class_name QuizScreen


var quiz: Quiz


static func display(q: Quiz) -> QuizScreen: 
	var screen: QuizScreen = GUICollection.quiz_screen.instantiate()
	GUIManager.set_gui_active(screen, true)
	screen.start(q)
	return screen
	
	
func start(q: Quiz) -> void: 
	quiz = q
	
	
