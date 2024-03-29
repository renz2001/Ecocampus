@tool
extends DialogueGUIManager


func start(arguments: DialogueArguments, title_variation_counter: PointCounterComponent) -> void: 
	super.start(arguments, title_variation_counter)
	GameManager.state_chart.send_event("dialogue")
	
	
