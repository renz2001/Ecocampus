extends NodeComponent
class_name SetGameStateOnGUIActive

@export var disabled: bool
@export var gui: GUI: 
	set(value): 
		gui = value
		if !gui.is_node_ready(): 
			await gui.ready
		gui.activated.connect(_on_activated)
		gui.deactivated.connect(_on_deactivated)

@export var activated_state: String
@export var deactivated_state: String
@export var debug: bool

func _on_activated() -> void: 
	if activated_state.is_empty() || disabled: 
		return
	if debug: 
		print(activated_state)
	GameManager.state_chart.send_event(activated_state)
	
	
func _on_deactivated() -> void: 
	if deactivated_state.is_empty() || disabled: 
		return
	if debug: 
		print(deactivated_state)
	if deactivated_state == "playing" && GUIManager.quiz_attempt_screen.visible: 
		return
	GameManager.state_chart.send_event(deactivated_state)
	
	
