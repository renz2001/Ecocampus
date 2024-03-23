extends Node


func _input(event: InputEvent) -> void: 
	if event.is_action_pressed("open_customize_character_screen"): 
		GUIManager.toggle_gui(GUIManager.customize_character_screen) 
