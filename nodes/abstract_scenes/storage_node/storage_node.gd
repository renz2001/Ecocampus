extends EntityNode
class_name StorageNode




func _on_mouse_drag_drop_area_dropped(drag_data: Dictionary) -> void:
	inventory.add_item(drag_data["item"])

