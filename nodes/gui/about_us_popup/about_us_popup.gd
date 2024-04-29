extends GUI
class_name AboutUsPopup


func _on_on_tap_set_active_pressed() -> void:
	GUIManager.remove_gui(self)
