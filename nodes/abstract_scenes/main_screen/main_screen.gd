extends CanvasLayer
class_name MainScreen

@export var send_event: String = "main_menu"


func _ready() -> void: 
	GameManager.state_chart.send_event("main_screen")
	GameManager.state_chart.send_event(send_event)
	if GUIManager.transitions_manager.middle_transition: 
		GUIManager.transitions_manager.middle_transition.end()
