extends Node2D
class_name LevelNode

@export var id_component: IDComponent
@export var quests_collection: QuestsCollection


func _ready() -> void:
	GameManager.state_chart.send_event("playing")
	
	if SaveManager.does_save_file_name_exists("save_file_1"): 
		SaveManager.set_current_game_save_from_file_name("save_file_1")
		SaveManager.load_current_game_save(str(id_component.data.value))
	quests_collection.start_quests()


func _notification(what: int) -> void: 
	if what == NOTIFICATION_WM_CLOSE_REQUEST || what == NOTIFICATION_CRASH: 
		SaveManager.save_game()
		SaveManager.save_game_to_file(true)
		
		
