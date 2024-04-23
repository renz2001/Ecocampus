extends Button
class_name OnTapSetActive

@export var gui: GUI
@export var set_active: bool


func _on_pressed() -> void:
	GUIManager.set_gui_active(gui, set_active)
