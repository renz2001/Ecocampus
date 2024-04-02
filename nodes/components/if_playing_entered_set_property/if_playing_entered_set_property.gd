extends ConditionalSetPropertyComponent
class_name IfPlayingEnteredSetProperty


func _ready() -> void: 
	super._ready()
	update_condition()
	GameManager.playing_state.state_entered.connect(
		func(): 
			update_condition()
	)
	

func _condition() -> bool: 
	printerr(GameManager.is_playing())
	return GameManager.is_playing()
