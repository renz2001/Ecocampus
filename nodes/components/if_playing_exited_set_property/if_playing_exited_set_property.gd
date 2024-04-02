extends ConditionalSetPropertyComponent
class_name IfPlayingExitedSetProperty


func _ready() -> void: 
	super._ready()
	update_condition()
	GameManager.playing_state.state_exited.connect(
		func(): 
			update_condition()
	)


func _condition() -> bool: 
	return GameManager.is_playing()
