extends NodeComponent
class_name SetGameStateOnGUIActive

@export var gui: GUI: 
	set(value): 
		gui = value
		if !gui.is_node_ready(): 
			await gui.ready
		gui.activated.connect(_on_activated)
		gui.deactivated.connect(_on_deactivated)

@export var activated_state: String
@export var deactivated_state: String


func _on_activated() -> void: 
	GameManager.state_chart.send_event(activated_state)
	
	
func _on_deactivated() -> void: 
	GameManager.state_chart.send_event(deactivated_state)
	
	
