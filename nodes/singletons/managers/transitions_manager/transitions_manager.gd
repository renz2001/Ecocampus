@tool
extends GUI
class_name TransitionsManager 

signal transition_started
signal transition_ended
signal middle_transition_started

@export var middle_transition_control: Control
@export var start_transition_control: Control
@export var end_transition_control: Control

@export var animation_player: AnimationPlayer

var middle_transition: MiddleTransitionGUI
var start_transition: StartTransitionGUI
var end_transition: EndTransitionGUI
var transitioning: bool

var middle_transition_condition: MiddleTransitionGUI.EndCondition

func prepare_transition(transition: GUITransition) -> void: 
	if transition == null: 
		#push_error("TransitionsMAnager: Cannot prepare transition if it is null. ")
		return
		
	if transition.start_transition != null: 
		start_transition = transition.start_transition.instantiate()
		start_transition_control.add_child(start_transition)
		
	if transition.end_transition != null: 
		end_transition = transition.end_transition.instantiate()
		end_transition_control.add_child(end_transition)
		middle_transition_started.emit()
		
	if transition.middle_transition != null: 
		middle_transition = transition.middle_transition.instantiate()
		middle_transition_control.add_child(middle_transition)
	
	
func start(transition: GUITransition, _middle_transition_condition: MiddleTransitionGUI.EndCondition =  MiddleTransitionGUI.EndCondition.TIMEOUT) -> void: 
	GUIManager.set_gui_active(self, true)
	middle_transition_condition = _middle_transition_condition
	transitioning = true
	if transition == null: 
		end()
		return
		
	if transition.end_transition != null: 
		end_transition.ended.connect(_on_end_transition_ended, CONNECT_ONE_SHOT)
	
	if transition.middle_transition != null: 
		middle_transition.end_condition = _middle_transition_condition
		middle_transition.ended.connect(_on_middle_transition_ended.bind(transition), CONNECT_ONE_SHOT)
	else: 
		end_transition.play()
		
	if transition.start_transition != null: 
		start_transition.ended.connect(_on_start_transition_ended.bind(transition), CONNECT_ONE_SHOT)
		start_transition.play()
	else: 
		middle_transition.play()
	transition_started.emit()
	
	
func _on_start_transition_ended(transition: GUITransition) -> void: 
	if transition.middle_transition != null: 
		if is_instance_valid(middle_transition): 
			middle_transition.play()
	elif transition.end_transition != null: 
		end_transition.play()
	else: 
		end()
	
	
func _on_middle_transition_ended(transition: GUITransition) -> void: 
	if transition.end_transition != null: 
		end_transition.play()
	else: 
		end()
	
	
func _on_end_transition_ended() -> void: 
	end()


func end() -> void: 
	transitioning = false
	GUIManager.set_gui_active(self, false)
	transition_ended.emit()
	
	
