extends Resource
class_name ChangeSceneArguments

@export_file(".tscn") var scene: String
@export var transition: GUITransition


func set_scene(s: String) -> ChangeSceneArguments: 
	scene = s
	return self


func set_transition(t: GUITransition) -> ChangeSceneArguments: 
	transition = t
	return self
	
	
