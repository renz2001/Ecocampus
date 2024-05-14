extends OnPressedComponent
class_name OnPressedExitToMainMenu

@export var gui: GUI
@export var to_main_menu: ChangeSceneComponent


func _on_pressed() -> void: 
	var config: AlertDialogConfig = AlertDialogConfig.new()
	config.description = "Exit to main menu?"
	config.yes_func = func(): 
		to_main_menu.change()
		GUIManager.set_gui_active(gui, false)
	AlertDialogBase.display(config)
	
	
