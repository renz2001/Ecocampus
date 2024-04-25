extends EcoQuestTaskScriptCondition
class_name TurnOffFaucetTaskCondition 

var listener: WorldEventListener

func _initialized() -> void: 
	WorldEventManager.event_called.connect(_on_event_called)
	initialized()
	
	
func initialized() -> void: 
	var faucets: Array[Node] = tree.get_nodes_in_group("Faucet")
	for faucet: Faucet in faucets: 
		if !faucet.is_on(): 
			counter.increment()
		else: 
			faucet.turned_off.connect(_on_bulb_turned_off)
	
	
func _on_event_called(event: String, _by: Node, _args: Array) -> void: 
	if event == "ready": 
		initialized()
	
	
func _on_bulb_turned_off() -> void: 
	counter.increment()
	
	
func _finished() -> void: 
	var faucets: Array[Node] = tree.get_nodes_in_group("Faucet")
	for faucet: Faucet in faucets: 
		if faucet.is_on(): 
			faucet.turned_off.disconnect(_on_bulb_turned_off)

