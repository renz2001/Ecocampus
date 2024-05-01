@tool
extends GUI
class_name VictoryScreen


func _on_return_home_pressed() -> void:
	SaveManager.remove_save_file("save_file_1s")
	GUIManager.set_gui_active(self, false)
	
	
func _deactivated() -> void: 
	queue_free()
