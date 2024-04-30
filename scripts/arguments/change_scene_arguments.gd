extends Resource
class_name ChangeSceneArguments

@export_file(".tscn") var scene: String
@export var transition: GUITransition
@export var middle_transition_end_condition: MiddleTransitionGUI.EndCondition

func set_scene(s: String) -> ChangeSceneArguments: 
	scene = s
	return self


func set_transition(t: GUITransition) -> ChangeSceneArguments: 
	transition = t
	return self
	
func set_middle_transition_end_condition(t: MiddleTransitionGUI.EndCondition) -> ChangeSceneArguments: 
	middle_transition_end_condition = t
	return self
