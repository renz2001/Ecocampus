extends TextureButtonPlus
class_name CustomizeCharacterIconButton

@export var icon: TextureRect

func _on_pressed() -> void:
	GUIManager.toggle_gui(GUIManager.customize_character_screen)
	update()
	if !GUIManager.customize_character_screen.visibility_changed.is_connected(_on_visibility_changed):
		GUIManager.customize_character_screen.visibility_changed.connect(_on_visibility_changed)
	
	
func _on_visibility_changed() -> void: 
	update()
	
	
func update() -> void: 
	icon.visible = !GUIManager.customize_character_screen.is_visible_in_tree()
	close_icon.visible = GUIManager.customize_character_screen.is_visible_in_tree()
