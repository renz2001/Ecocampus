extends OnPressedComponent
class_name OnPressedExitToMainMenu

@export var to_main_menu: ChangeSceneComponent


func _on_pressed() -> void: 
	var config: AlertDialogConfig = AlertDialogConfig.new()
	config.description = "Exit to main menu?"
	config.yes_func = func(): to_main_menu.change()
	AlertDialogBase.display(config)
	
	
