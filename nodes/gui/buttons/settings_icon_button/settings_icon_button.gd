extends TextureButtonPlus
class_name SettingsIconButton


func _on_pressed() -> void:
	GUIManager.toggle_gui(GUIManager.settings_menu)

