extends Node2D
class_name LevelNode

static var entered_tree: int = 0

@export var to_map_picker: ChangeSceneComponent
@export var id_component: IDComponent
#@export var quests_collection: QuestsCollection

# TODO: Implement task condition script for segregating all trash. 

#func _enter_tree() -> void: 
	#printerr(get_children())

func _ready() -> void: 
	SaveManager.loaded_data.connect(
		func(_data: GameSave): 
			if GUIManager.transitions_manager.middle_transition: 
				GUIManager.transitions_manager.middle_transition.end()
			WorldEventManager.call_event("ready", self)
	, CONNECT_ONE_SHOT
	)
	entered_tree += 1
	
	var show_nodes: Array[Node] = get_tree().get_nodes_in_group("Faucet")
	show_nodes.append_array(get_tree().get_nodes_in_group("LightBulb"))
	show_nodes.append_array(get_tree().get_nodes_in_group("LightSwitch"))
	
	var hide_nodes: Array[Node] = get_tree().get_nodes_in_group("QuestEntity")
	hide_nodes.append_array(show_nodes)
	
	for node: Node in hide_nodes: 
		node.hide()
		
		
	GameManager.state_chart.send_event("playing")
	if SaveManager.does_save_file_name_exists("save_file_1") && entered_tree == 1: 
		SaveManager.set_current_game_save_from_file_name("save_file_1")
		SaveManager.load_current_game_save(str(id_component.data.value))
	else: 
		SaveManager.load_current_game_save(str(id_component.data.value))
	GlobalData.achievements_tracker.update_victory()
	
	await get_tree().process_frame
	
	#printerr("show: ", GameManager.faucets_show)
	if GameManager.faucets_show: 
		for node: Node in show_nodes: 
			#printerr(node)
			#printerr(node.disabled)
			if node.disabled: 
				continue
			node.show()
			if node.get("state"): 
				node.set("state", GlobalEnums.OnState.ON)
				#printerr("State: ", node.state)
			#printerr("shown: ", node.visible)
	#quests_collection.start_quests()


func _notification(what: int) -> void: 
	if GameManager.is_close_request(what): 
		SaveManager.save_game()
		SaveManager.save_game_to_file(true)
	#elif what == NOTIFICATION_WM_GO_BACK_REQUEST: 
		#to_map_picker.change()

