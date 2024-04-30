extends Node2D
class_name LevelNode

@export var id_component: IDComponent
#@export var quests_collection: QuestsCollection

# TODO: Implement task condition script for segregating all trash. 

#func _enter_tree() -> void: 
	#printerr(get_children())


func _enter_tree() -> void:
	GameManager.state_chart.send_event("playing")
	if SaveManager.does_save_file_name_exists("save_file_1"): 
		SaveManager.set_current_game_save_from_file_name("save_file_1")
		SaveManager.load_current_game_save(str(id_component.data.value))
		await SaveManager.loaded_data
	if GUIManager.transitions_manager.middle_transition: 
		GUIManager.transitions_manager.middle_transition.end()
	#quests_collection.start_quests()
	
	
func _ready() -> void: 
	WorldEventManager.call_event("ready", self)


func _notification(what: int) -> void: 
	if what == NOTIFICATION_WM_CLOSE_REQUEST || what == NOTIFICATION_CRASH: 
		SaveManager.save_game()
		SaveManager.save_game_to_file(true)
		
		
