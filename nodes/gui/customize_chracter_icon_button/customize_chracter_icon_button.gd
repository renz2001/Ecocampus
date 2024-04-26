extends TextureButtonPlus


func _on_pressed() -> void:
	GUIManager.toggle_gui(GUIManager.customize_character_screen)
