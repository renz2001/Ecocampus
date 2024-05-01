@tool
extends GUI
class_name VictoryScreen


func _activated() -> void: 
	super._activated()


func _on_return_home_pressed() -> void:
	GUIManager.set_gui_active(self, false)
	GameManager.reset_all_data()
	
	
func _deactivated() -> void: 
	queue_free()
