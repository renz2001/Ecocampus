extends ConditionalSetPropertyComponent


func _ready() -> void: 
	super._ready()
	update_condition()
	GameManager.state_chart.event_received.connect(
		func(e_vent: String): get_tree().current_scene.ready.connect(update_condition)
	)


func _condition() -> bool: 
	return GameManager.is_playing()
	
	
