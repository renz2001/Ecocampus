extends Node

@export var to_main_menu: ChangeSceneComponent

func _input(event: InputEvent) -> void: 
	if event.is_action_pressed("open_customize_character_screen"): 
		GUIManager.toggle_gui(GUIManager.customize_character_screen) 
		
	elif event.is_action_pressed("reset_game"): 
		to_main_menu.change()
		GameManager.reset_all_data()

