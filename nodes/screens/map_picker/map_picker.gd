extends MainScreen

@export var to_main_menu: ChangeSceneComponent

#func _ready() -> void: 
	#SaveManager.save_game()
	#SaveManager.save_game_to_file(true)


func _notification(what: int) -> void: 
	if GameManager.is_close_request(what):
		SaveManager.save_game()
		SaveManager.save_game_to_file(true)
	elif what == NOTIFICATION_WM_GO_BACK_REQUEST: 
		to_main_menu.change()

