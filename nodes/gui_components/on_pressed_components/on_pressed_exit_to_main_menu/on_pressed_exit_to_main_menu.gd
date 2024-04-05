extends OnPressedComponent
class_name OnPressedExitToMainMenu

@export var to_main_menu: ChangeSceneComponent


func _on_pressed() -> void: 
	to_main_menu.change()
	
	
