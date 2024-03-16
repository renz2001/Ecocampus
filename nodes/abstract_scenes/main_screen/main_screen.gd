extends CanvasLayer
class_name MainScreen


func _ready() -> void: 
	GameManager.state_chart.send_event("main_menu")
