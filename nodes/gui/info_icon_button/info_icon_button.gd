extends TextureButtonPlus
class_name InfoIconButton



func _on_pressed() -> void:
	GUIManager.add_gui(GUICollection.about_us_popup.instantiate())

