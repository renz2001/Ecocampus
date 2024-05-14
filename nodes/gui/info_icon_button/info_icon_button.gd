extends TextureButtonPlus
class_name InfoIconButton

@export var icon: TextureRect

var about_us: AboutUsPopup: 
	get: 
		return get_tree().get_first_node_in_group("AboutUs")

func _on_pressed() -> void:
	GUIManager.add_gui(GUICollection.about_us_popup.instantiate())
	update()
	if !about_us.visibility_changed.is_connected(_on_visibility_changed):
		about_us.visibility_changed.connect(_on_visibility_changed)
	
	
func _on_visibility_changed() -> void: 
	update()
	
	
func update() -> void: 
	icon.visible = !about_us.is_visible_in_tree()
	close_icon.visible = about_us.is_visible_in_tree()

