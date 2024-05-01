extends Node2D
class_name LevelNode

static var entered_tree: int = 0

@export var to_map_picker: ChangeSceneComponent
@export var id_component: IDComponent
#@export var quests_collection: QuestsCollection

# TODO: Implement task condition script for segregating all trash. 

#func _enter_tree() -> void: 
	#printerr(get_children())


func _enter_tree() -> void: 
	SaveManager.loaded_data.connect(
		func(_data: GameSave): 
			if GUIManager.transitions_manager.middle_transition: 
				GUIManager.transitions_manager.middle_transition.end()
			WorldEventManager.call_event("ready", self)
	, CONNECT_ONE_SHOT
	)
	entered_tree += 1
	GameManager.state_chart.send_event("playing")
	if SaveManager.does_save_file_name_exists("save_file_1") && entered_tree == 1: 
		SaveManager.set_current_game_save_from_file_name("save_file_1")
		SaveManager.load_current_game_save(str(id_component.data.value))
	else: 
		SaveManager.load_current_game_save(str(id_component.data.value))
	GlobalData.achievements_tracker.update_victory()
	#quests_collection.start_quests()
	


func _notification(what: int) -> void: 
	if GameManager.is_close_request(what): 
		SaveManager.save_game()
		SaveManager.save_game_to_file(true)
		print("Is close request")
	elif what == NOTIFICATION_WM_GO_BACK_REQUEST: 
		to_map_picker.change()
		
