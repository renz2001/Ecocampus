extends OnPressedComponent
class_name OnPressedOpenSettings


func _on_pressed() -> void: 
	GUIManager.set_gui_active(GUIManager.settings_menu, true)
	
	
