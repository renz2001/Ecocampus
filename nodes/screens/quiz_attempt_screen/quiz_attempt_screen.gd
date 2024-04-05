extends GUI
class_name QuizAttemptScreen

@export var assesment_music: AudioManagerPlayer

var quiz: Quiz


static func display(q: Quiz) -> QuizAttemptScreen: 
	var screen: QuizAttemptScreen = GUIManager.quiz_attempt_screen
	GUIManager.set_gui_active(screen, true)
	screen.start(q)
	return screen
	
	
static func conceal() -> QuizAttemptScreen: 
	var screen: QuizAttemptScreen = GUIManager.quiz_attempt_screen
	screen.close()
	return screen
	
	
func start(q: Quiz) -> void: 
	quiz = q
	assesment_music.play()


func _on_quiz_attempt_gui_deactivated() -> void:
	close()


func close() -> void: 
	GUIManager.set_gui_active(self, false)
	
