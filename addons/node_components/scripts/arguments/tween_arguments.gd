@tool
extends Resource
class_name TweenArguments

@export var transition_type: Tween.TransitionType = Tween.TRANS_QUAD
@export var ease_type: Tween.EaseType = Tween.EASE_IN_OUT
@export var duration: float = 0


func set_ease_type(value: Tween.EaseType) -> TweenArguments: 
	ease_type = value
	return self


func set_duration(value: float) -> TweenArguments: 
	duration = value
	return self
	
	
func set_transition_type(value: Tween.TransitionType) -> TweenArguments: 
	transition_type = value
	return self


func create_tween(tree: SceneTree) -> Tween: 
	var tween: Tween = tree.create_tween().set_ease(ease_type).set_trans(transition_type)
	return tween
