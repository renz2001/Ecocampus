extends CanvasLayer
class_name MainScreen


func _ready() -> void: 
	GameManager.state_chart.send_event("main_menu")
	if GUIManager.transitions_manager.middle_transition: 
		GUIManager.transitions_manager.middle_transition.end()
