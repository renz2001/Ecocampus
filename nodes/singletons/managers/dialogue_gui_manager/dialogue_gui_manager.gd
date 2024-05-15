@tool
extends DialogueGUIManager


func _ready() -> void: 
	super._ready()
	if Engine.is_editor_hint(): 
		return
	#DialogueManager.dialogue_ended.connect(
		#func(_dialogue: DialogueResource): 
			#GameManager.state_chart.send_event("playing")
	#)


func start(arguments: DialogueArguments, title_variation_counter: PointCounterComponent) -> void: 
	super.start(arguments, title_variation_counter)
	GameManager.state_chart.send_event("dialogue")
	
	
