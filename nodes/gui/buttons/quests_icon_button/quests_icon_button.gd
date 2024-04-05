extends TextureButtonPlus
class_name QuestsIconButton



func _on_pressed() -> void:
	var menu: QuestsMenu = GroupNodeFetcher.get_first_node("QuestsMenu")
	GUIManager.toggle_gui(menu)
