extends NodeComponent 
class_name DialogueStarter 


@export var dialogue: DialogueArguments
@export var extra_node_game_states: Array[Node]

@export_group("Dependencies")
@export var title_variation_counter: PointCounterComponent


func start() -> void: 
	if !dialogue: 
		return
	GUIManager.dialogue_gui_manager.start(dialogue.add_extra_game_states(extra_node_game_states), title_variation_counter)
	
	
