extends GUI
class_name DialogueGUI 


@export var close_when_clicked_outside: bool = true

var mouse_inside: bool


func _deactivated() -> void: 
	GUIManager.remove_gui(self)


func _on_mouse_entered() -> void:
	mouse_inside = true
	
	
func _on_mouse_exited() -> void:
	mouse_inside = false


func _unhandled_input(event: InputEvent) -> void: 
	if event.is_action_pressed("tap"): 
		if close_when_clicked_outside && mouse_inside == false: 
			GUIManager.set_active(self, false)
