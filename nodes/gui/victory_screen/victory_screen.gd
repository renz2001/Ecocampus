@tool
extends GUI
class_name VictoryScreen


func _activated() -> void: 
	super._activated()

func _on_return_home_pressed() -> void:
	GameManager.reset_all_data()
	GUIManager.set_gui_active(self, false)
	
	
func _deactivated() -> void: 
	queue_free()
