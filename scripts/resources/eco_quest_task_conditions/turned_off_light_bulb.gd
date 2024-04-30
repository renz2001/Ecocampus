extends EcoQuestTaskScriptCondition
class_name TurnOffLightBulbTaskCondition 

var listener: WorldEventListener

func _initialized() -> void: 
	if WorldEventManager.event_called.is_connected(_on_event_called): 
		WorldEventManager.event_called.connect(_on_event_called)
	initialized()
	
	
func initialized() -> void: 
	var light_bulbs: Array[Node] = tree.get_nodes_in_group("LightBulb")
	for bulb: LightBulb in light_bulbs: 
		if !bulb.is_on(): 
			counter.increment()
		else: 
			bulb.turned_off.connect(_on_bulb_turned_off)
	
	
func _on_event_called(event: String, _by: Node, _args: Array) -> void: 
	if event == "ready": 
		initialized()
	
	
func _on_bulb_turned_off() -> void: 
	counter.increment()
	
	
func _finished() -> void: 
	var light_bulbs: Array[Node] = tree.get_nodes_in_group("LightBulb")
	for bulb: LightBulb in light_bulbs: 
		if bulb.is_on(): 
			bulb.turned_off.disconnect(_on_bulb_turned_off)

