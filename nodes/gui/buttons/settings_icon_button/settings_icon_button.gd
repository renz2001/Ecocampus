extends TextureButtonPlus
class_name SettingsIconButton


func _on_pressed() -> void:
	GUIManager.set_gui_active(GUIManager.settings_menu, true)

